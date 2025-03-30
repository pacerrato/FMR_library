function F = fitResonance(obj, cutVariable)
%FITRESONANCE - Make fit of gain resonance
%   This FMR-Library function opens an app to make the fit of resonance
%   peaks of gain data.
%
%   Syntax
%     FITRESONANCE(obj)
%     FITRESONANCE(obj, cutVariable)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     cutVariable - Name of the cut column
%       "Frequency" (default) | "Field"
%
%   Output Arguments
%     F - Resonance parameters object
%       FMRData object
arguments
    obj (1,1) FMR_library.RawData {mustHaveAllColumns(obj)}
    cutVariable {mustBeTextScalar, ...
                 mustBeMember(cutVariable,["Frequency", ...
                                           "Field"])} = ...
                                           "Frequency"
end
    import FMR_library.FMRData
    import FMR_library.FitResonanceDisplay

    % Create return object
    F = FMRData();
    F.frequencyUnits = obj.frequencyUnits;
    F.fieldUnits = obj.fieldUnits;
    F.gainUnits = obj.gainUnits;    

    % Set resonant magnitude variables
    if (strcmp(cutVariable, "Frequency"))
        F.sweptMagnitude = "Field";
        F.linewidthUnits = obj.fieldUnits;
    else
        F.sweptMagnitude = "Frequency";
        F.linewidthUnits = obj.frequencyUnits;
    end

    % Open resonance fit display
    figObject = FitResonanceDisplay();
    figObject.fmrObject = F;
    figObject.cutVariable = cutVariable;
    figObject.uniqueCutVariableValues = unique(obj.getDataColumn(cutVariable));
    figObject.nCuts = numel(figObject.uniqueCutVariableValues);
    
    % Callback functions
    figObject.rightButtonFcn = @obj.changePlotAction;
    figObject.leftButtonFcn = @obj.changePlotAction;
    figObject.counterCallbackFcn = @obj.changePlotAction;
    figObject.deleteButtonFcn = @obj.changePlotAction;
    figObject.fitButtonFcn = @obj.makeResonanceFit;

    % Initialize figure
    figObject.init(obj);
end