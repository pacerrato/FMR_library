function I = getInitialParams(data, figObject, peakCenter)
%GETINITIALPARAMS - Get the initial parameters for a Lorentzian fit.
%   This FMR-Library function returns the initial parameters for a 
%   Voigt function fit of a given set of data.
%
%   Syntax
%     I = GETINITIALPARAMS(data, figObject, peakCenter)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     figObject - Figure object
%       FitResonanceDisplay object
%     peakCenter - Estimate of resonance
%       scalar
%
%   Output Arguments
%     I - Initial parameters
%       1-by-8 vector
arguments
    data (:,2) {mustBeNumeric}
    figObject (1,1) FMR_library.FitResonanceDisplay
    peakCenter (1,1) {mustBeNumeric}
end
    % Initialize parameters vector
    if (~isempty(figObject.lastInitialParams))
        I = figObject.lastInitialParams(2:end);
    else
        I = zeros(1, 8);
    end

    % Get data
    [xData, uniqueIdx] = unique(data(:,1));
    yData = data(uniqueIdx,2);
    
    % Background trend
    I(3) = peakCenter; % Hr
    fwhm = 0.5 * (I(2) + sqrt(I(2)^2 + 4*I(5)^2));
    I([6,7,8]) = getBgCoeff(xData, yData, peakCenter, fwhm, figObject.backgroundDeg); % Background parameters

    % If taken last iteration parameters, return
    if (~isempty(figObject.lastInitialParams))
        return
    end

    % Remove background
    yData = yData - (I(6) + I(7) * xData + I(8) * xData.^2);

    % Calculate peak position and height
    [peakHeight, peakIdx] = max(abs(yData));
    xPeak = xData(peakIdx);
    peakDisplacement = xPeak - peakCenter;
    peakSign = sign(yData(peakIdx)); % Sign of peak

    % Get phase and voigt function shape parameters
    yData = abs(yData);
    if (peakDisplacement >= 0)
        HWHM = fzero(@(x) interp1(xData(peakIdx:end) - xPeak, yData(peakIdx:end),x) - ...
                            0.5 * peakHeight, [0, xData(end) - xPeak]); % HWHM of peak
    
        deltaHk = fzero(@(x) interp1(xData(peakIdx:end) - xPeak, yData(peakIdx:end),x) - ...
                            0.25 * peakHeight, [0, xData(end) - xPeak]); % Half width at fourth maximum of peak
    else
        HWHM = -fzero(@(x) interp1(xData(1:peakIdx) - xPeak, yData(1:peakIdx),x) - ...
                            0.5 * peakHeight, [xData(1) - xPeak, 0]);% HWHM of peak
    
        deltaHk = -fzero(@(x) interp1(xData(1:peakIdx) - xPeak, yData(1:peakIdx),x) - ...
                            0.25 * peakHeight, [xData(1) - xPeak, 0]); % Half width at fourth maximum of peak
    end
    [beta, theta] = getVoigtParams(peakDisplacement, deltaHk / HWHM);

    % Calculate FWHM of Voigt function
    FWHM = 0.5 * HWHM *((1 - beta^2) * convLor(theta) + sqrt(((1 - beta^2) * convLor(theta))^2 +  4 * (beta * convGauss(theta))^2));
    FWHM = max(FWHM, 2*HWHM);
    bgParams = getBgCoeff(xData, data(uniqueIdx,2), peakCenter, FWHM, figObject.backgroundDeg); % Background parameters

    % Set initial parameters
    I(1) = pi/2 * FWHM * peakHeight * peakSign;           % Area
    I(2) = FWHM * (1 - beta^2);                           % FWHM Lorentzian
    I(3) = peakCenter;                                    % Hr
    I(4) = theta;                                         % Phase
    I(5) = FWHM * beta;                                   % FWHM Gaussian
    I([6,7,8]) = bgParams;                                % Offset, Slope, Quadratic coeff.
end

% Auxiliary functions to calculate conversion of peak HWHM to curve FWHM
function out = convLor(theta)
    % Conversion factor of lorentzian function
    out = 2*abs(sin(theta) ./ (1 - cos(theta) + 1e-6));
end

function out = convGauss(theta)
    % Conversion factor of Gaussian
    out = abs(0.556/(pi/2) * theta);
end

function params = getBgCoeff(xData, yData, peakCenter, fwhm, backgroundDeg)
%GETBGCOEFF - Calculate coefficients for background polynomial model.
%   This FMR-Library function returns the background polynomial
%   coefficients of a signal with a peak at peakCenter and a FWHM
%   of fwhm. The function first removes the peak from the data and
%   then fits the background.
%
%   Syntax
%     p = GETBGCOEFF(xData, yData, peakCenter, fwhm, backgroundDeg)
%
%   Input Arguments
%     xData - X data points
%       vector
%     yData - Y data points
%       vector
%     peakCenter - Peak center in x data units
%       scalar
%     fwhm - Full width at half maximum of the peak
%       scalar
%     backgroundDeg - Background polynomial degree
%       positive integer
%
%   Output Arguments
%     p - Polynomial coefficient in increasing order
%       1-by-n vector
    % If no FWHM was specified, take 25% of X range
    if (fwhm == 0)
        fwhm = 0.25 * abs(xData(end) - xData(1));
    end

    % Get background signal
    filter = (xData < peakCenter-fwhm) | (xData > peakCenter+fwhm); % Filter to remove peak from data
    xData = xData(filter);
    yData = yData(filter);
    % Fit polynomial
    params = flip(polyfit(xData, yData, backgroundDeg));
    if backgroundDeg < 2
        params(3) = 0;
    end
end