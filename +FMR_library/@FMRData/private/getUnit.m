function u = getUnit(obj, name)
%GETUNIT - Get the unit of a variable
%   This FMR-Library function returns the stored unit for a variable.
%
%   Syntax
%     u = GETUNIT(obj, name)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     name - Name of the variable
%       character vector | string scalar
%
%   Output Arguments
%     u - Unit
%       character vector | string scalar
arguments
    obj (1,1) FMR_library.FMRData
    name (1,1) {mustBeTextScalar}
end
    switch name
        case "Area"
            if strcmp(obj.sweptMagnitude, "Field")
                u = strjoin([obj.fieldUnits,"×",obj.gainUnits],"");
            else
                u = strjoin([obj.frequencyUnits,"×",obj.gainUnits],"");
            end
        case "Frequency"
            u = obj.frequencyUnits;
        case "Field"
            u = obj.fieldUnits;
        case "GaussianLinewidth"
            if strcmp(obj.sweptMagnitude, "Field")
                u = obj.fieldUnits;
            else
                u = obj.frequencyUnits;
            end
        case "LorentzianLinewidth"
            if strcmp(obj.sweptMagnitude, "Field")
                u = obj.fieldUnits;
            else
                u = obj.frequencyUnits;
            end
        case "Offset"
            u = obj.gainUnits;
        case "Slope"
            if strcmp(obj.sweptMagnitude, "Field")
                u = strjoin([obj.gainUnits, "/", obj.fieldUnits],"");
            else
                u = strjoin([obj.gainUnits, "/", obj.frequencyUnits],"");
            end
        case "Phase"
            u = "rad";
        otherwise
            error("Unit name does not exist.");
    end
end