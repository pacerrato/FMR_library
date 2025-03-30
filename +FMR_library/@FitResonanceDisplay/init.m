function init(obj, dataObj)
%INIT - Initialization of variables and interface current data in fit interface
%   This FMR-Library function initializes the variables and interface
%   for resonance fit.
%
%   Syntax
%     INIT(obj,dataObj)
%
%   Input Arguments
%     obj - Figure object
%       FitResonanceDisplay object
%     dataObj - Data object
%       RawData object
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    dataObj (1,1) FMR_library.RawData
end
    % Initialize fit parameters variables
    obj.fitParams = NaN(obj.nCuts, 9);
    obj.uncertFitParams = NaN(obj.nCuts, 9);

    % Update button status and counter
    obj.counterMax.String = strjoin(["/", num2str(obj.nCuts)]);
    obj.formatFitAxes(dataObj);
    obj.currentIdx = 0;
    obj.rightPress;            
end
