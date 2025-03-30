function ax = plot(obj, xVariable, yVariable, ax)
%PLOT - Plot two variables stored in the object
%   This FMR-Library function makes a plot of two variables.
%
%   Syntax
%     ax = PLOT(obj, xVariable, yVariable)
%     ax = PLOT(obj, xVariable, yVariable, ax)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     xVariable - x axis variable name
%       "Area" | "Frequency" | "Field" | "GaussianLinewidth" | 
%       "LorentzianLinewidth" | "Offset" | "Phase" | "Slope"
%     yVariable - y axis variable name
%       "Area" | "Frequency" | "Field" | "GaussianLinewidth" | 
%       "LorentzianLinewidth" | "Offset" | "Phase" | "Slope"
%     ax - Axes handle to make the plot
%       Axes object | PolarAxes object | GeographicAxes object
%
%   Output Arguments
%     ax - Axes handle of the plot
%       Axes object | PolarAxes object | GeographicAxes object
arguments
    obj (1,1) FMR_library.FMRData
    xVariable {mustBeTextScalar}
    yVariable {mustBeTextScalar}
    ax (1,1) {mustBeUnderlyingType(ax, 'matlab.graphics.axis.Axes')} = getSingleAxis()
end
    % Get the plot data
    xData = obj.getDataColumn(xVariable);
    yData = obj.getDataColumn(yVariable);
    uxData = obj.getDataColumn(strjoin([xVariable,"Uncertainty"],""));
    uyData = obj.getDataColumn(strjoin([yVariable,"Uncertainty"],""));

    % Make plot
    hold(ax, "on");
    errorbar(xData, yData, uyData, uyData, uxData, uxData,'.');
    hold(ax, "off");

    % Format
    xlabel(ax,strjoin([xVariable, " (",obj.getUnit(xVariable),")"],""), ...
           "FontUnits", "normalized", ...
           "FontSize", 0.035);
    ylabel(ax,strjoin([yVariable, " (",obj.getUnit(yVariable),")"],""), ...
           "FontUnits", "normalized", ...
           "FontSize", 0.035);
end