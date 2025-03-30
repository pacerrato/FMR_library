function mustBeValidColumnName(obj,cName)
%MUSTBEVALIDCOLUMNNAME Validate that name is a valid column name for the class
%   This FMR-Library function throws an error if input name is not a
%   valid name defined by the class.
%
%   Syntax
%     MUSTBEVALIDCOLUMNNAME(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Name of the column
%       character vector | 1-by-n cell array of character vectors | 
%       1-by-n string array
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustBeText}
end
    if ~ismember(cName, obj.validColumnNames)
        error("Input name is not allowed for this class.");
    end
end