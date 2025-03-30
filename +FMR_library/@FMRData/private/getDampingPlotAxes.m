function ax = getDampingPlotAxes(obj)
%GETDAMPINGPLOTAXES - Get an axes handle formatted for damping plot
%   This FMR-Library function returns an axes handle with title,
%   labels, box and grid for the plot of the damping fit.
% 
%   Syntax
%     ax = GETDAMPINGPLOTAXES(obj)
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
    % Create figure object and axes handle
    fig = figure();
    ax = axes('Parent', fig, 'Box', 'on');
    grid on;

    % Axes titles
    title(ax, "Damping fit", ...
              "FontUnits", "normalized", ...
              "FontSize", 0.05);

    % Axes labels
    if (strcmp(obj.sweptMagnitude, "Frequency"))
        xDataLabel = "Field";
        xUnits = obj.fieldUnits;
    else
        xDataLabel = "Frequency";
        xUnits = obj.frequencyUnits;
    end

    xlabel(ax,strjoin([xDataLabel, " (", xUnits,")"],""), ...
              "FontUnits", "normalized", ...
              "FontSize", 0.035);
    ylabel(ax,strjoin(["Linewidth (", obj.linewidthUnits,")"],""), ...
              "FontUnits", "normalized", ...
              "FontSize", 0.035);
end