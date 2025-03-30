function [fitresult, gof] = makeLinearFit(x, y)
%MAKELINEARFIT - Fit input data to a line
%   This FMR-Library function fits the input data to a line.
%
%   Syntax
%     [fitresult,gof] = MAKELINEARFIT(x,y)
%
%   Input Arguments
%     x - x data
%       n-by-1 vector
%     y - y data
%       n-by-1 vector
%
%   Output Arguments
%     fitresult - Fit result
%       cfit
%     gof - Goodness-of-fit statistics
%       gof structure
arguments
    x {mustBeVector, mustBeNumeric}
    y {mustBeVector, mustBeNumeric}
end
    % Fit options
    ft = fittype('poly1');
    fo = fitoptions('Method', 'LinearLeastSquares');

    % Make fit
    [fitresult, gof] = fit(x, y, ft, fo);
end