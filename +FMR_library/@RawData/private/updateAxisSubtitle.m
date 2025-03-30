function updateAxisSubtitle(obj, figObject, ax)
%UPDATEAXISSUBTITLE - Update the axis subtitle
%   This FMR-Library function changes the axis subtitle to the current
%   cut variable value.
%
%   Syntax
%     UPDATEAXISSUBTITLE(obj,figObject,ax)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     figObject - Figure object
%       FitResonanceDisplay object
%     ax - Axes handle
%       Axes object
arguments
    obj (1,1) FMR_library.RawData
    figObject (1,1) FMR_library.FitResonanceDisplay
    ax (1,1) {mustBeUnderlyingType(ax,'matlab.graphics.axis.Axes')}
end
    % Get column name and variable value
    columnName = figObject.cutVariable;
    currentValue = figObject.currentCutVarValue;

    % Set subtitle
    subtitle(ax,strjoin([columnName,": ", num2str(currentValue)," ", obj.getUnit(columnName)],""));
end
