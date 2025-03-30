function saveFitParams(obj, fitresult, gof)
%SAVEFITPARAMS - Save fit parameters
%   This FMR-Library function saves the fit parameters and its 
%   uncertainties to object.
%
%   Syntax
%     SAVEFITPARAMS(obj,fitresult,gof)
%
%   Input Arguments
%     obj - Figure object
%       FitResonanceDisplay object
%     fitresult - Fit result
%       cfit
%     gof - Goodness-of-fit statistics
%       gof structure
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    fitresult (1,1) {mustBeUnderlyingType(fitresult, 'cfit')}
    gof (1,1) {mustBeUnderlyingType(gof, 'struct')}
end
    % Get fit parameters
    confIntervals = confint(fitresult);
    fitParameters = [obj.currentCutVarValue, coeffvalues(fitresult)];
    uFitParams    = [gof.rsquare, 0.5*abs(confIntervals(1,:) - confIntervals(2,:))];
    
    % Write parameters
    obj.fitParams(obj.currentIdx, :)       = fitParameters;
    obj.uncertFitParams(obj.currentIdx, :) = uFitParams;
    obj.lastInitialParams                  = fitParameters;
end