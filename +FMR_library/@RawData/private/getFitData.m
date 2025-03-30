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
        % Set searching region to (hr +- rangeMult * FWHM);
        iniParams = figObject.lastInitialParams;
        FWHM = 0.5 * (iniParams(3) + sqrt(iniParams(3)^2 + (2*iniParams(6))^2));
        rangeMult = figObject.rangeMult;
        xlims = [iniParams(4) - rangeMult * FWHM, ...
                 iniParams(4) + rangeMult * FWHM];
    end

    % Crop data
    data = [figObject.xData, figObject.yData];
    D = cropDataToBoundaries(data, xlims);
end