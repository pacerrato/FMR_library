function P = getFitParams(fitresult)
%GETFITPARAMS Get fit parameters with uncertainty from cfit object
%GETFITPARAMS - Get the fit parameters with uncertainty from a cfit object
%   This FMR-Library function returns a matrix with the fit parameters
%   in column (:,1) and their uncertainties in column (:,2).
% 
%   Syntax
%     P = GETFITPARAMS(fitresult)
%
%   Input Arguments
%     fitresult - Fit result
%       cfit
%
%   Output Arguments
%     P - Parameters and uncertainties
%       matrix
arguments
    fitresult (1,1) {mustBeUnderlyingType(fitresult, 'cfit')}
end
    % Retreive parameters value from fit
    P = coeffvalues(fitresult);

    % Calculate uncertainties
    confIntervals = confint(fitresult);
    fitUncert = abs(confIntervals(1,:) - confIntervals(2,:))/2;

    % Store parameters in matrix
    P = [P', fitUncert'];
end