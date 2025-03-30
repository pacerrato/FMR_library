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
    obj (1,1) FMR_library.RawData
    name (1,1) {mustBeTextScalar}
end
    switch name
        case "Frequency"
            u = obj.frequencyUnits;
        case "Field"
            u = obj.fieldUnits;
        case "Gain"
            u = obj.gainUnits;
        otherwise
            error("Unit name does not exist.");
    end
end