function plotFitCurve(ax, xLims, fitresult, n)
%PLOTFITCURVE - Make a plot of the fitted data and fit curve
%   This FMR-Library function plots the fit curve in the range of xLims.
%
%   Syntax
%     PLOTFITCURVE(ax, xLims, fitresult)
%     PLOTFITCURVE(ax, xLims, fitresult, n)
%
%   Input Arguments
%     ax - Axes handle
%       Axes object
%     xLims - Limits to plot the fit 
%       matrix
%     fitresult - Fit result
%       cfit
%     n - Number of points to plot in x range
%       1000 (default) | positive scalar
arguments
    ax (1,1) {mustBeUnderlyingType(ax, 'matlab.graphics.axis.Axes')}
    xLims (1,2) {mustBeNumeric}
    fitresult (1,1) {mustBeUnderlyingType(fitresult, 'cfit')}
    n (1,1) {mustBePositive, mustBeInteger} = 1000
end
    % Make x point array
    x = linspace(xLims(1), xLims(2), n);

    % Plot fitted curve
    hold(ax, "on")
    plot(ax, x, fitresult(x));
    hold(ax, "off")
    ax.NextPlot = "replacechildren";
end