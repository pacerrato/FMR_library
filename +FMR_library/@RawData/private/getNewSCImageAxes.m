function ax = getNewSCImageAxes(obj)
%GETNEWSCIMAGEAXES - Get a formatted axes handle.
%   This FMR-Library function returns a formatted axes handle with
%   title, axis labels, box and grid to plot the SC image of gain data.
%
%   Syntax
%     ax = GETNEWSCIMAGEAXES(obj)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%
%   Output Arguments
%     ax - Axes handle
%       Axes object
arguments
    obj (1,1) FMR_library.RawData {mustHaveAllColumns(obj)}
end
    % Get axes
    ax = getSingleAxis();
    
    % Figure formatting
    title(ax, strjoin(["Gain (", obj.gainUnits,") color plot"],""), ...
              "FontUnits", "normalized", ...
              "FontSize", 0.05);
    xlabel(ax, strjoin(["Field (", obj.fieldUnits, ")"],""), ...
               "FontUnits", "normalized", ...
               "FontSize", 0.035);
    ylabel(ax, strjoin(["Frequency (", obj.frequencyUnits, ")"],""), ...
               "FontUnits", "normalized", ...
               "FontSize", 0.035);
end