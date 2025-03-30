function ax = plot2d(obj, ax, opts)
%PLOT2D - Plot the 2D image (pseudo-colors image) of the data
%   This FMR-Library function makes a 2D color plot of gain values
%   where the x axis is the field and the y axis is the frequency.
%
%   Syntax
%     ax = PLOT2D(obj)
%     ax = PLOT2D(obj, ax)
%     ax = PLOT2D(___,Name,Value)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     ax - Axes handle to make the plot
%       Axes object | PolarAxes object | GeographicAxes object
%
%   Name-Value Arguments
%     PlotDerivative - Plot the derivative of the gain
%       false (default) | true
%     DerivativeVariable - Variable to take gain derivative with respect to
%       "Frequency" (default) | "Field"
%
%   Output Arguments
%     ax - Axes handle of the plot
%       Axes object | PolarAxes object | GeographicAxes object
arguments
    obj (1,1) FMR_library.RawData {mustHaveAllColumns(obj)}
    ax (1,1) {mustBeUnderlyingType(ax, 'matlab.graphics.axis.Axes')} = obj.getNewSCImageAxes()
    opts.PlotDerivative (1,1) logical = false
    opts.DerivativeVariable {mustBeTextScalar, ...
                             mustBeMember(opts.DerivativeVariable, ...
                                          ["Frequency", "Field"])} = ...
                                           "Field"
end
    % Get the plot array data and the bounds
    plotArray = obj.getGain2DArray();
    xBounds = obj.getBounds("Field");
    yBounds = obj.getBounds("Frequency");
    x = linspace(xBounds(1), xBounds(2), size(plotArray, 2));
    y = linspace(yBounds(1), yBounds(2), size(plotArray, 1));

    % Get derivative if necessary
    if (opts.PlotDerivative)
        switch opts.DerivativeVariable
            case "Frequency"
                if (size(plotArray,1) > 1)
                    plotArray = diff(plotArray, 1, 1);
                    y = y(1:end-1);
                else
                    warning("Not enough data to make derivative. Plotting normal 2D plot.")
                end
            case "Field"
                if (size(plotArray,2) > 1)
                    plotArray = diff(plotArray, 1, 2);
                    x = x(1:end-1);
                else
                    warning("Not enough data to make derivative. Plotting normal 2D plot.")
                end
        end
    end

    % Make plot
    hold(ax, "on");
    pcolor(ax, x, y, plotArray, 'EdgeColor','none')
    hold(ax, "off");

    % Plot formatting
    axis(ax, "tight"); % Set plot limits
    ax.Layer = 'top'; % Box on top of image

    % Color range. Set from 5% to 95% of gain value
    minColor = quantile(plotArray, 0.05, "all");
    maxColor = quantile(plotArray, 0.95, "all");
    set(ax, 'CLim', [minColor, maxColor]);
end