function ax = getKittelPlotAxes(obj)
%GETKITTELPLOTAXES - Get an axes handle formatted for Kittel fit
%   This FMR-Library function returns an axes handle with title,
%   labels, box and grid for the plot of the Kittel fit.
% 
%   Syntax
%     ax = GETKITTELPLOTAXES(obj)
%
%   Input Arguments
%     obj - FMR data object
%       FMRData object
%
%   Output Arguments
%     ax - Axes handle
%       Axes object
arguments
    obj (1,1) FMR_library.FMRData
end
    % Create fit object
    fig = figure();
    ax = axes('Parent', fig, 'Box', 'on');
    grid on;

    % Axes titles
    title(ax, "Kittel equation fit", ...
              "FontUnits", "normalized", ...
              "FontSize", 0.05);

    % Axes labels
    xlabel(ax,strjoin(["External field (", obj.fieldUnits,")"],""), ...
              "FontUnits", "normalized", ...
              "FontSize", 0.035);
    ylabel(ax,strjoin(["Frequency (", obj.frequencyUnits,")"],""), ...
              "FontUnits", "normalized", ...
              "FontSize", 0.035);
end