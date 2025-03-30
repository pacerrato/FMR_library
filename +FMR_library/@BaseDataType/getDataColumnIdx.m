function I = getDataColumnIdx(obj, cName)
%GETDATACOLUMNIDX - Get the index of a column
%   This FMR-Library function returns the index of the column with name
%   cName of the array of data.
%
%   Syntax
%     I = GETDATACOLUMNIDX(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Name of the column
%       character vector | 1-by-n cell array of character vectors | 
%       1-by-n string array
%     
%   Output Arguments
%     I - Indices of the requested columns
%       n-by-1 array
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustBeVector, mustExistColumnName(obj,cName)}
end
    % Get columnName indices
    [~, I] = ismember(cName, obj.columnNames);    
end