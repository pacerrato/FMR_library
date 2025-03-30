function changePlotAction(obj, figObject)
%CHANGEPLOTACTION - Update plot display in resonance fit interface
%   This FMR-Library function plots the gain data and if a fit
%   for the data exists, it is plot in the right axes.
%
%   Syntax
%     CHANGEPLOTACTION(obj, figObject)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     figObject - Figure object
%       FitResonanceDisplay object
arguments
    obj (1,1) FMR_library.RawData
    figObject (1,1) FMR_library.FitResonanceDisplay
end
    % Get current index x and y data and save it
    [xData, yData] = obj.getResonancePlotData(figObject.cutVariable, ...
                                              figObject.currentCutVarValue);
    figObject.xData = xData;
    figObject.yData = yData;

    % Plot current data in left axis
    obj.plotCurrentData(figObject);

    % If not fitting, plot fit axis data
    if (~figObject.isFittingData)
        obj.plotFitData(figObject)
    end
end