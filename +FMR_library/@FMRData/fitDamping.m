function [D, ax] = fitDamping(obj, opts)
%FITDAMPING - Make the damping fit of the data
%   This FMR-Library function makes a linear fit with the available
%   linewidth and cut variable data and returns the damping parameters
%   and the axes handle used for the plotting.
% 
%   Syntax
%     D = FITDAMPING(obj)
%     D = FITDAMPING(___,Name,Value)
%
%     [D,ax] = FITDAMPING(___)
%
%   Input Arguments
%     obj - FMR data object
%       FMR data object
%
%   Name-Value Arguments
%     LinewidthType - Linewidth to plot
%       "lorentzian" (default) | "gaussian"
%     MakePlot - Make plot of the data and fit result
%       true (default) | false
%     AxesHandle - Axes handle to plot the result
%       Axes object
%
%   Output Arguments
%     D - Fitted damping parameters, uncertainties and r^2
%       struct
%     ax - Axes object where the plot was made
%       Axes object
arguments
    obj (1,1) FMR_library.FMRData
    opts.LinewidthType {mustBeTextScalar, ...
                        mustBeMember(opts.LinewidthType, ...
                                     ["lorentzian", "gaussian"])} = "lorentzian"
    opts.MakePlot (1,1) logical = true
    opts.AxesHandle (1,1) {mustBeUnderlyingType(opts.AxesHandle,'matlab.graphics.axis.Axes')} = obj.getDampingPlotAxes()
end 
    % Get fit data
    [xData, cutVar] = obj.getCutData;
    if strcmp(opts.LinewidthType, "lorentzian")
        yData = obj.getDataColumn("LorentzianLinewidth");
        yVar = "LorentzianLinewidth";
    else
        yData = obj.getDataColumn("GaussianLinewidth");
        yVar = "GaussianLinewidth";
    end

    % Make damping fit
    [fitresult, gof] =  makeLinearFit(xData, yData);

    % Plot data and line fit
    if (opts.MakePlot)
        ax = opts.AxesHandle;
        obj.plot(cutVar, yVar, opts.AxesHandle);
        plotFitCurve(ax, ...
                     getBounds(xData), ...
                     fitresult, ...
                     max(5*length(xData), 1000));
    end

    % Retreive parameters
    fitParams = getFitParams(fitresult);

    % Save parameters in struct
    D.damping = obj.kittelParameters.gyromagneticRatio(1) /2 * fitParams(1,:);
    D.inhomogeneousDamping = fitParams(2,:);
    D.rsqr = gof.rsquare;
    obj.dampingParameters = D;
end