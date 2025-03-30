function mustExistColumnName(obj, cName)
%MUSTEXISTCOLUMNNAME Assert the column name exists
%   Asserts that the input name is a string and it exists.
%MUSTEXISTCOLUMNNAME Validate that the input name is a column of the object
%   This FMR-Library function throws an error if input name is not a
%   column of the object.
%
%   Syntax
%     MUSTEXISTCOLUMNNAME(obj, cName)
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
    if ~ismember(cName, obj.columnNames)
        error("Column name could not be found")
    end
end