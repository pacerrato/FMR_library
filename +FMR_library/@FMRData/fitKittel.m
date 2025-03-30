function [K, ax] = fitKittel(obj, kittelType, opts)
%FITKITTEL - Make Kittel fit 
%   This FMR-Library function makes a Kittel equation fit with the 
%   available data and returns the Kittel fit parameters and the axes 
%   handle used for the plotting.
%
%   Syntax
%     K = FITKITTEL(obj,kittelType)
%     K = FITKITTEL(___,Name,Value)
%
%     [K, ax] = FITKITTEL(___)
%
%   Input Arguments
%     obj - FMR data object
%       FMR data object
%     kittelType - Kittel equation type
%       "inPlane" | "outOfPlane" | "electronSpinResonance" 
%
%   Name-Value Arguments
%     MakePlot - Make plot of the data and fit result
%       false (default) | true
%     AxesHandle - Axes handle to plot the result
%       Axes object
%
%   Output Arguments
%     K - Fitted Kittel equation parameters, uncertainties and r^2
%       struct
%     ax - Axes object where the plot was made
%       Axes object
arguments
    obj (1,1) FMR_library.FMRData
    kittelType {mustBeTextScalar, ...
                mustBeMember(kittelType, ["inPlane", ...
                                          "outOfPlane", ...
                                          "electronSpinResonance", ...
                                          "antiferromagnetic", ...
                                          "bulk"])}
    opts.MakePlot (1,1) logical = true
    opts.AxesHandle (1,1) {mustBeUnderlyingType(opts.AxesHandle,'matlab.graphics.axis.Axes')} = obj.getKittelPlotAxes()
                            
end
    % Get data to fit
    xData = obj.getDataColumn("Field");
    yData = obj.getDataColumn("Frequency");

    switch kittelType
        case "inPlane"
            [K, fitresult] =  makeInPlaneKittelFit(xData, yData);
        case "outOfPlane"
            [K, fitresult] =  makeOutOfPlaneKittelFit(xData, yData);
        case "electronSpinResonance"
            [K, fitresult] =  makeElectronSpinResonanceFit(xData, yData);
        % case "antiferromagnetic"
        %     [K, fitresult] =  makeAntiferromagneticeKittelFit(xData, yData);
        % case "bulk"
        %     [K, fitresult] =  makeBulkKittelFit(xData, yData);
    end
    
    % Save parameters
    obj.kittelParameters = K;

    % Plot data and line fit
    if (opts.MakePlot)
        ax = opts.AxesHandle;
        obj.plot("Field", "Frequency", ax);
        plotFitCurve(ax, ...
                     getBounds(xData), ...
                     fitresult, ...
                     max(5*length(xData), 1000));
    end
end