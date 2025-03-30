function plotCurrentData(obj, figObject)
%PLOTCURRENTDATA - Display current data in fit interface
%   This FMR-Library function plots the gain data for the current
%   cut variable value.
%
%   Syntax
%     PLOTCURRENTDATA(obj, figObject)
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
    % Plot data
    plot(figObject.axesArray(1), figObject.xData, figObject.yData, '.');

    % Update axis subtitle
    obj.updateAxisSubtitle(figObject, figObject.axesArray(1));
end