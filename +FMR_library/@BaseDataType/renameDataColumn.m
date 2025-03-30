function renameDataColumn(obj, cName, newName)
%RENAMEDATACOLUMN - Rename a column from data array
%   This FMR-Library function renames a column from the data array.
%
%   Syntax
%     RENAMEDATACOLUMN(obj, cName, newName)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Column name
%       character vector | 1-by-n cell array of character vectors | 
%       1-by-n string array
%     newName - New column name
%       character vector | 1-by-n cell array of character vectors | 
%       1-by-n string array
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustExistColumnName(obj,cName)}
    newName {mustBeEqualSize(newName,cName),mustBeValidColumnName(obj,newName)}
end
    % Get the column index
    columnIdx = obj.getDataColumnIdx(cName);

    % Change the name of the column
    obj.columnNames(columnIdx) = string(newName);
end