function [K, fitresult] = makeOutOfPlaneKittelFit(x, y)
%MAKEOUTOFPLANEKITTELFIT - Fit input data to out-of-plane Kittel equation
%   This FMR-Library function fits the input data to the out-of-plane
%   Kittel equation and returns a struct with the fit parameters.
%
%   Syntax
%     K = MAKEOUTOFPLANEKITTELFIT(x,y)
%
%     [K, fitresult] = MAKEOUTOFPLANEKITTELFIT(x,y)
%
%   Input Arguments
%     x - x data
%       n-by-1 vector
%     y - y data
%       n-by-1 vector
%
%   Output Arguments
%     K - Fitted Kittel equation parameters, uncertainties and r^2
%       struct
%     fitresult - Fit result
%       cfit
arguments
    x {mustBeVector, mustBeNumeric}
    y {mustBeVector, mustBeNumeric}
end
    import FMR_library.outOfPlaneKittel

    % Initial params
    iniGyromRatio = abs((y(end) - y(1)) / (x(end) - x(1)));
    initialParams = [iniGyromRatio, 0];

    % Make fit
    ft = fittype(@(gamma, Meff, x) outOfPlaneKittel(x, gamma, Meff),...
                 'independent', 'x', 'dependent', 'y');
    fo = fitoptions('Method', 'NonlinearLeastSquares',...
                    'Display', 'notify',...
                    'MaxFunEvals', 5000,...
                    'MaxIter', 5000, ...
                    'TolFun', 1e-6, ...
                    'StartPoint', initialParams, ...
                    'Lower', [-Inf, -Inf], ...
                    'Upper', [Inf, Inf]);

    [fitresult, gof] = fit(x, y, ft, fo);

    % Retreive parameters
    fitParams = getFitParams(fitresult);

    % Save parameters in struct
    K.kittelType = "outOfPlane";
    K.gyromagneticRatio = fitParams(1,:);
    K.effectiveMagnetization = fitParams(2,:);
    K.rsqr = gof.rsquare;
end