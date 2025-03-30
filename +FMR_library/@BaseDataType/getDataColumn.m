function C = getDataColumn(obj, cName)
%GETDATACOLUMN - Get a column of the data array
%   This FMR-Library function returns the column with name cName
%   of the array of data.
%
%   Syntax
%     C = GETDATACOLUMN(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Name of the column
%       character vector | 1-by-n cell array of character vectors | 
%       1-by-n string array
%     
%   Output Arguments
%     C - Requested data column
%       n-by-1 array
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustBeVector, mustExistColumnName(obj,cName)}
end
    I = obj.getDataColumnIdx(cName);
    C = obj.dataArray(:,I);
end