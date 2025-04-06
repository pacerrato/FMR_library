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
%     kittelType - Kittel equation type
%       "inPlane" | "outOfPlane" | "electronSpinResonance" 
%     LinewidthType - Linewidth to plot
%       "lorentzian" (default) | "gaussian"
%     xVariable - Independent variable
%       "Frequency" | "Field"
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
    opts.kittelType {mustBeTextScalar, ...
                     mustBeMember(opts.kittelType, ["inPlane", ...
                                                    "outOfPlane", ...
                                                    "electronSpinResonance", ...
                                                    "antiferromagnetic", ...
                                                    "bulk"])}
    opts.xVariable {mustBeTextScalar, mustBeMember(opts.xVariable, ["Frequency", "Field"])}
    opts.MakePlot (1,1) logical = true
    opts.AxesHandle (1,1) {mustBeUnderlyingType(opts.AxesHandle,'matlab.graphics.axis.Axes')} = obj.getDampingPlotAxes()
end 
    import FMR_library.inPlaneKittel
    import FMR_library.outOfPlaneKittel
    import FMR_library.ESRKittel

    % Get X data
    if (ismember("xVariable", fields(opts)))
        xVar = opts.xVariable;
        xData = obj.getDataColumn(xVar);
    else
        [xData, xVar] = obj.getCutData;
    end

    % Get Y data
    if strcmp(opts.LinewidthType, "lorentzian")
        yData = obj.getDataColumn("LorentzianLinewidth");
        yVar = "LorentzianLinewidth";
    else
        yData = obj.getDataColumn("GaussianLinewidth");
        yVar = "GaussianLinewidth";
    end

    % Get frequency dependence on X variable
    k = obj.kittelParameters;
    if (strcmp(xVar, "Field"))
        switch k.kittelType
            case "inPlane"
                freq = @(x) inPlaneKittel(x, k.gyromagneticRatio(1), k.effectiveMagnetization(1), k.anisotropyField(1));
            case "outOfPlane"
                freq = @(x) outOfPlaneKittel(x, k.gyromagneticRatio(1), k.effectiveMagnetization(1));
            case "electronSpinResonance"
                freq = @(x) ESRKittel(x, k.gyromagneticRatio(1), k.magneticSusceptibility(1));
            otherwise
                error("This kind of Kittel equation has not yet been implemented in damping fit");
        end
    else
        freq = @(x) x;
    end
    deltaH = @(x, alpha, inhDamp) 2 / k.gyromagneticRatio(1) * alpha * freq(x) + inhDamp; 

    % Get linewidth fit equation
    if (strcmp(obj.sweptMagnitude, "Frequency"))
        switch k.kittelType
            case "inPlane"
                fiteq = @(x, alpha, inhDamp) k.gyromagneticRatio(1) .* sqrt(1 + ((k.gyromagneticRatio(1) * k.effectiveMagnetization(1))./(2 * freq(x))).^2) .* deltaH(x, alpha, inhDamp);
            case "outOfPlane"
                fiteq = @(x, alpha, inhDamp) k.gyromagneticRatio(1) .* deltaH(x, alpha, inhDamp);
            case "electronSpinResonance"
                fiteq = @(x, alpha, inhDamp) k.gyromagneticRatio(1) .* sqrt(1 + k.magneticSusceptibility(1)) .* deltaH(x, alpha, inhDamp);
            otherwise
                error("This kind of Kittel equation has not yet been implemented in damping fit");
        end
    else
        fiteq = deltaH;
    end
    
    % Make damping fit
    [fitresult, gof] = makeDampingfit(xData, yData, fiteq);

    % Plot data and line fit
    if (opts.MakePlot)
        ax = opts.AxesHandle;
        obj.plot(xVar, yVar, ax);
        plotFitCurve(ax, ...
                     getBounds(xData), ...
                     fitresult, ...
                     max(5*length(xData), 1000));
    end
    
    % Retreive parameters
    fitParams = getFitParams(fitresult);

    % Save parameters in struct
    D.damping = fitParams(1,:);
    D.inhomogeneousDamping = fitParams(2,:);
    D.rsqr = gof.rsquare;
    obj.dampingParameters = D;
end

function [fitresult, gof] = makeDampingfit(x, y, fiteq)
%MAKEDAMPINGFIT - Fit input data to appropiate damping equation
%   This FMR-Library function fits the input data to the appropriate
%   damping equation taking into account the units of the linewidth
%   and units of the independent variable.
%
%   Syntax
%     [fitresult,gof] = MAKEDAMPINGFIT(x,y,fiteq)
%
%   Input Arguments
%     x - x data
%       n-by-1 vector
%     y - y data
%       n-by-1 vector
%     fiteq - Equation to fit
%       function handle
%
%   Output Arguments
%     fitresult - Fit result
%       cfit
%     gof - Goodness-of-fit statistics
%       gof structure
arguments
    x {mustBeVector, mustBeNumeric}
    y {mustBeVector, mustBeNumeric}
    fiteq (1,1) {mustBeUnderlyingType(fiteq,'function_handle')}
end
    % Make fit
    ft = fittype(@(alpha, inhDamping, x) fiteq(x, alpha, inhDamping),...
                 'independent', 'x', 'dependent', 'y');
    fo = fitoptions('Method', 'NonlinearLeastSquares',...
                    'Display', 'notify',...
                    'MaxFunEvals', 5000,...
                    'MaxIter', 5000, ...
                    'TolFun', 1e-6, ...
                    'StartPoint', [0, 0], ...
                    'Lower', [-Inf, -Inf], ...
                    'Upper', [Inf, Inf]);

    [fitresult, gof] = fit(x, y, ft, fo);
end