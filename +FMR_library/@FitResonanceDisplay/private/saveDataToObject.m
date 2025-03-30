function fmrObject = saveDataToObject(obj,~,~)
%SAVEDATATOOBJECT Save the fit data from local variables to output object
%   Save the fit parameters and their uncertainties to
%   FMR output object.
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    ~ 
    ~ 
end
    % Get fit parameters and purge NaN values
    [fitParameters, rmIdx]= rmmissing(obj.fitParams, 1);

    % Write values to fmrObject
    fmrObject = obj.fmrObject;
    if ~isempty(fmrObject.columnNames)
        fmrObject.removeDataColumn(fmrObject.columnNames);
    end

    % Cut variable
    fmrObject.addData(obj.cutVariable, fitParameters(:,1), true);
    fmrObject.addData(strjoin([obj.cutVariable,"Uncertainty"],""), zeros(fmrObject.nRows,1), true);

    % Non-cut variable (resonance variable)
    fmrObject.addData(obj.nonCutVariable, fitParameters(:,4), true);
    fmrObject.addData(strjoin([obj.nonCutVariable,"Uncertainty"],""), obj.uncertFitParams(~rmIdx,4), true);

    % Area
    fmrObject.addData("Area", fitParameters(:,2), true)
    fmrObject.addData("AreaUncertainty", obj.uncertFitParams(~rmIdx, 2), true);

    % Phase
    fmrObject.addData("Phase", fitParameters(:,5), true)
    fmrObject.addData("PhaseUncertainty", obj.uncertFitParams(~rmIdx, 5), true);

    % Lorentzian Linewidth
    fmrObject.addData("LorentzianLinewidth", fitParameters(:,3), true)
    fmrObject.addData("LorentzianLinewidthUncertainty", obj.uncertFitParams(~rmIdx, 3), true);

    % Gaussian Linewidth
    fmrObject.addData("GaussianLinewidth", fitParameters(:,6), true)
    fmrObject.addData("GaussianLinewidthUncertainty", obj.uncertFitParams(~rmIdx, 6), true);

    % Offset
    fmrObject.addData("Offset", fitParameters(:,7), true)
    fmrObject.addData("OffsetUncertainty", obj.uncertFitParams(~rmIdx, 7), true);

    % Slope
    fmrObject.addData("Slope", fitParameters(:,8), true)
    fmrObject.addData("SlopeUncertainty", obj.uncertFitParams(~rmIdx, 8), true);
end