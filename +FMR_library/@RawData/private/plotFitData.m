function plotFitData(obj, figObject)
%PLOTFITDATA - Display fitted data in fit interface
%   This FMR-Library function plots the gain data for the current
%   cut variable value and the fitted curve on top of it.
%
%   Syntax
%     PLOTFITDATA(obj,figObject)
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
    % Axes handle and subtitle
    axesHandle = figObject.axesArray(2);

    % Update fit axis subtitle
    obj.updateAxisSubtitle(figObject, axesHandle);

    % Return if fit data does not exist
    fitParams = figObject.fitParams(figObject.currentIdx,:);
    if (anynan(fitParams))
        figObject.setRsqr("");
        cla(axesHandle);
        return
    end

    % Get plot domain
    FWHM = 0.5 * (fitParams(3) + sqrt(fitParams(3)^2 + (2*fitParams(6))^2));
    rangeMult = figObject.plotRangeMult;
    xLimits = [fitParams(4) - rangeMult * FWHM, ...
               fitParams(4) + rangeMult * FWHM];

    % Get current index x and y data
    xData = figObject.xData;
    yData = figObject.yData;

    fitPlotX = linspace(xLimits(1), xLimits(2), 1000);

    % Plot data
    import FMR_library.voigtModel
    plot(axesHandle, xData, yData, '.');

    % Plot fitted curve
    hold(axesHandle, "on")
    plot(axesHandle, fitPlotX, voigtModel(fitPlotX, ...
                                          fitParams(2), ...
                                          fitParams(3), ...
                                          fitParams(4), ...
                                          fitParams(5), ...
                                          fitParams(6), ...
                                          fitParams(7), ...
                                          fitParams(8), ...
                                          fitParams(9)));
    hold(axesHandle, "off")
    axesHandle.NextPlot = "replacechildren";
    xlim(axesHandle, xLimits)

    % Display r^2
    rsqr = figObject.uncertFitParams(figObject.currentIdx,1);
    rsqr = num2str(rsqr, 3);
    figObject.setRsqr(rsqr);         
end 