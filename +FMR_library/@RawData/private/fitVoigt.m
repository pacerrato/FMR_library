function [fitresult, gof] = fitVoigt(data, initialParams, backgroundDeg)
%FITVOIGT - Fit input data to Voigt function
%   This FMR-Library function performs a fit of the data to a Voigt
%   function with a given set of initial parameters.
%
%   Syntax
%     fitobject = FITVOIGT(data,initialParams,backgroundDeg)
%     [fitobject,gof] = FITVOIGT(data,initialParams,backgroundDeg)
%
%   Input Arguments
%     data - Data to fit
%       matrix
%     A - Array to fill
%       vector
%     backgroundDeg - Degree of polynomial for background fit
%       logical
%
%   Output Arguments
%     fitobject - Fit result
%       cfit
%     gof - Goodness-of-fit statitstics
%       gof structure
arguments 
    data (:,2) {mustBeNumeric}
    initialParams {mustBeNumeric, mustBeVector}
    backgroundDeg (1,1) {mustBeNumeric}
end
    import FMR_library.voigtModel

    % Set parameters bounds depending on type of background
    switch backgroundDeg
        case 0 
            initialParams(7) = 0;
            initialParams(8) = 0;
            lowerBounds = [-Inf, 0, -Inf, -pi/2, 1e-8, -Inf, 0, 0];
            upperBounds = [Inf, Inf, Inf, pi/2, Inf, Inf, 0, 0];
        case 1
            initialParams(8) = 0;
            lowerBounds = [-Inf, 0, -Inf, -pi/2, 1e-8, -100, -20, 0];
            upperBounds = [Inf, Inf, Inf, pi/2, Inf, 50, 20, 0];
        case 2
            lowerBounds = [-Inf, 0, -Inf, -pi/2, 1e-8, -Inf, -Inf, -Inf];
            upperBounds = [Inf, Inf, Inf, pi/2, Inf, Inf, Inf, Inf];
    end

    ft = fittype(@(a1, lLW, hr, theta, gLW, c0, c1, c2, x) ...
                 voigtModel(x, a1, lLW, hr, theta, gLW, c0, c1, c2),...
                 'independent', 'x', 'dependent', 'y');
    fo = fitoptions('Method', 'NonlinearLeastSquares',...
                    'Display', 'notify',...
                    'MaxFunEvals', 10000,...
                    'MaxIter', 10000, ...
                    'TolFun', 1e-6, ...
                    'TolX', 1e-6, ...
                    'StartPoint', initialParams, ...
                    'Lower', lowerBounds, ...
                    'Upper', upperBounds);

    [fitresult, gof] = fit(data(:,1), data(:,2), ft, fo);
end