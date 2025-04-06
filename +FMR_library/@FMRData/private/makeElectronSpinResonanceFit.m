function [K, fitresult] = makeElectronSpinResonanceFit(x, y)
%MAKEELECTRONSPINRESONANCEFIT - Fit input data to ESR Kittel equation
%   This FMR-Library function fits the input data to the ESR
%   Kittel equation and returns a struct with the fit parameters.
%
%   Syntax
%     K = MAKEELECTRONSPINRESONANCEFIT(x,y)
%
%     [K, fitresult] = MAKEELECTRONSPINRESONANCEFIT(x,y)
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
    import FMR_library.ESRKittel

    % Initial params
    initialParams = [28, 0];

    % Make fit
    ft = fittype(@(gamma, magSuscept, x) ESRKittel(x, gamma, magSuscept),...
                 'independent', 'x', 'dependent', 'y');
    fo = fitoptions('Method', 'NonlinearLeastSquares',...
                    'Display', 'notify',...
                    'MaxFunEvals', 5000,...
                    'MaxIter', 5000, ...
                    'TolFun', 1e-6, ...
                    'StartPoint', initialParams, ...
                    'Lower', [28, -Inf], ...
                    'Upper', [28, Inf]);

    [fitresult, gof] = fit(x, y, ft, fo);

    % Retreive parameters
    fitParams = getFitParams(fitresult);

    % Save parameters in struct
    K.kittelType = "electronSpinResonance";
    K.gyromagneticRatio = fitParams(1,:);
    K.magneticSusceptibility = fitParams(2,:);
    K.rsqr = gof.rsquare;
end