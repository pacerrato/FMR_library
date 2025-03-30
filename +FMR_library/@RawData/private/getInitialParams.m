function I = getInitialParams(data)
%GETINITIALPARAMS - Get the initial parameters for a Lorentzian fit.
%   This FMR-Library function returns the initial parameters for a 
%   Voigt function fit of a given set of data.
%
%   Syntax
%     I = GETINITIALPARAMS(data)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%
%   Output Arguments
%     I - Initial parameters
%       1-by-8 vector
arguments
    data (:,2) {mustBeNumeric}
end
    % Get data
    [xData, uniqueIdx] = unique(data(:,1));
    yData = data(uniqueIdx,2);
    
    % Set noise parameters
    I = zeros(1, 8);
    I(7) = (yData(1) - yData(end)) / (xData(1) - xData(end));       % c1
    I(6) = yData(1) - I(7) * xData(1);                              % c0
    yData = yData - (I(7) .* xData + I(6));                         % Detrend linearly

    % Calculate center of resonance and sign
    [~, peakProm] = islocalmax(abs(yData));
    peakCenter = sum(peakProm .* xData) / sum(peakProm); % Weighted mean of peaks and x position

    % Calculate peak position and height
    [peakHeight, peakIdx] = max(abs(yData));
    xPeak = xData(peakIdx);
    peakDisplacement = xPeak - peakCenter;
    peakSign = sign(yData(peakIdx)); % Sign of peak

    % Get phase and voigt function shape parameters
    yData = abs(yData);
    HWHM = fzero(@(x) interp1(xData(peakIdx:end), yData(peakIdx:end),x) - 0.5 * peakHeight, [xData(peakIdx), xData(end)]);
    HWHM = abs(HWHM - xPeak); % HWHM of peak

    Hk = fzero(@(x) interp1(xData(peakIdx:end), yData(peakIdx:end),x) - 0.25 * peakHeight, [xData(peakIdx), xData(end)]);
    deltaHk = abs(Hk - xPeak); % Half width at fourth maximum of peak

    [beta, theta] = getVoigtParams(peakDisplacement, deltaHk / HWHM);

    % Calculate FWHM of Voigt function
    FWHM = 0.5 * HWHM *((1 - beta^2) * convLor(theta) + sqrt(((1 - beta^2) * convLor(theta))^2 +  4 * (beta * convGauss(theta))^2));
    FWHM = max(FWHM, 2*HWHM);

    % Set initial parameters
    I(1) = max(0.5 * peakHeight * FWHM, 1e-4) * peakSign; % Area
    I(2) = FWHM * (1 - beta^2);                           % FWHM Lorentzian
    I(3) = peakCenter;                                    % Hr
    I(4) = theta;                                         % Phase
    I(5) = FWHM * beta;                                   % FWHM Gaussian
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