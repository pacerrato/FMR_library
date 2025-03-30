function [K, fitresult] = makeInPlaneKittelFit(x, y)
%MAKEINPLANEKITTELFIT - Fit input data to in-plane Kittel equation
%   This FMR-Library function fits the input data to the in-plane
%   Kittel equation and returns a struct with the fit parameters.
%
%   Syntax
%     K = MAKEINPLANEKITTELFIT(x,y)
%
%     [K, fitresult] = MAKEINPLANEKITTELFIT(x,y)
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
    import FMR_library.inPlaneKittel

    % Initial params
    iniGyromRatio = abs((y(end) - y(1)) / (x(end) - x(1)));
    initialParams = [iniGyromRatio, 0, 0];

    % Make fit
    ft = fittype(@(gamma, Meff, aniField, x) inPlaneKittel(x, gamma, Meff, aniField),...
                 'independent', 'x', 'dependent', 'y');
    fo = fitoptions('Method', 'NonlinearLeastSquares',...
                    'Display', 'notify',...
                    'MaxFunEvals', 5000,...
                    'MaxIter', 5000, ...
                    'TolFun', 1e-6, ...
                    'StartPoint', initialParams, ...
                    'Lower', [-Inf, -Inf -Inf], ...
                    'Upper', [Inf, Inf, Inf]);

    [fitresult, gof] = fit(x, y, ft, fo);

    % Retreive parameters
    fitParams = getFitParams(fitresult);

    % Save parameters in struct
    K.gyromagneticRatio = fitParams(1,:);
    K.effectiveMagnetization = fitParams(2,:);
    K.anisotropyField = fitParams(3,:);
    K.rsqr = gof.rsquare;
end