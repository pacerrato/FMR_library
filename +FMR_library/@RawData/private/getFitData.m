function D = getFitData(figObject)
%GETFITDATA - Get the data to make the fit
%   This FMR-Library function returns the cropped data to perform a
%   Lorentzian fit. If the function cannot calculate the region of
%   interest on its own, it will ask the user to input 2 points that
%   define the search region for the peak.
%
%   Syntax
%     D = GETFITDATA(figObject)
%
%   Input Arguments
%     figObject - Figure object
%       FitResonanceDisplay object
%
%   Output Arguments
%     D - Cropped fit data
%       matrix
arguments
    figObject (1,1) FMR_library.FitResonanceDisplay
end
    % If lastInitialParams is empty, ask user for input
    if (isempty(figObject.lastInitialParams))
        % Write instructions
        figObject.setInstructions(strjoin(["Click twice in the ",...
            "plot on the left to select a horizontal range", ...
            "that contains the peak.",...
            newline, "Press ENTER to exit."],""));

        % User input for fit range
        [xlims, ~] = ginput(2);

        % Remove instructions
        figObject.setInstructions("");

        % If input is less than 2 points, return empty array
        if (length(xlims) < 2)
            D = [];
            return
        end
    else
        % Set searching region to (res +- rangeMult * FWHM);
        res = estimateResonance(figObject);
        iniParams = figObject.lastInitialParams;
        FWHM = 0.5 * (iniParams(3) + sqrt(iniParams(3)^2 + (2*iniParams(6))^2));
        rangeMult = figObject.rangeMult;
        xlims = [res - rangeMult * FWHM, ...
                 res + rangeMult * FWHM];
    end

    % Crop data
    data = [figObject.xData, figObject.yData];
    D = cropDataToBoundaries(data, xlims);
end

function r = estimateResonance(figObject)
%ESTIMATERESONANCE - Make an estimate of the resonance position
%   This FMR-Library function returns an estimate of the resonance
%   position in the X axis. It uses linear interpolation with the last
%   two data available from the resonance fits.
%
%   r = ESTIMATERESONANCE(figObject)
%
%   Input Arguments
%     figObject - Figure object
%       FitResonanceDisplay object
%
%   Output Arguments
%     r - Resonance position
%       numerical scalar
    % Get non-empty inital parameters
    iniParams = figObject.fitParams;
    iniParams(all(isnan(iniParams), 2), :) = [];

    % Get last two points to make linear interpolation
    dataPoint1 = iniParams(end, [1,4]);
    if (size(iniParams,1)>1)
        dataPoint2 = iniParams(end-1, [1,4]);
    else
        dataPoint2 = [0,0];
    end
    
    % Make linear interpolation of resonance point
    slope = (dataPoint1(2) - dataPoint2(2)) / (dataPoint1(1) - dataPoint2(1));
    offset = dataPoint1(2) - slope * dataPoint1(1);
    r = figObject.currentCutVarValue * slope + offset;
    % disp([num2str(figObject.currentCutVarValue) '*'  num2str(slope) '+' num2str(offset) '=' num2str(r)]);
end