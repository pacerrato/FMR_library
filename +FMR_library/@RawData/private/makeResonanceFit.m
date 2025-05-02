function tf = makeResonanceFit(obj, figObject)
%MAKERESONANCEFIT - Make the resonance fit of current data in display
%   This FMR-Library function performs the fitting of the resonance
%   data currently in display on the fitting interface.
%
%   Syntax
%     tf = MAKERESONANCEFIT(obj,figObject)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     figObject - Figure object
%       FitResonanceDisplay object
%
%   Output Arguments
%     tf - The fitting was successful
%       logical
arguments
    obj (1,1) FMR_library.RawData
    figObject (1,1) FMR_library.FitResonanceDisplay
end
    % Get fit data
    fitData = getFitData(figObject);

    % If not enough data to fit, return false
    if (size(fitData,1) < 10)
        tf = false;
        return
    end

    % Get initial parameters
    initialParams = getInitialParams(fitData, figObject);

    % Make fit
    [fitresult, gof] = fitVoigt(fitData, initialParams, figObject.quadraticNoise);
    
    % Save fit parameters
    figObject.saveFitParams(fitresult, gof);
    
    % Plot fit and set r^2 value
    plotFitData(obj, figObject);

    % The fit was successful if r^2 > opts.minrsquare
    tf = gof.rsquare > figObject.minrsqr;
end 