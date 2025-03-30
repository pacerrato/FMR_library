function S = getDataSubset(obj, cName, x)
%GETDATASUBSET - Get data subset that checks cName == x
%   This FMR-Library function returns subset of the data array that
%   fulfills the condition getDataColumn(cName) == x.
%
%   Syntax
%     S = GETDATASUBSET(obj, cName, x)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Name of the column
%       character vector | string scalar
%     x - Filter value of column cName
%       numeric scalar
%     
%   Output Arguments
%     S - Subset of data such that getDataColumn(cName) == x
%       matrix
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustBeTextScalar, mustExistColumnName(obj,cName)}
    x (1,1) {mustBeNumeric}
end    
    column = obj.getDataColumn(cName);
    filter = obj.getFilter(column, x);
    S = obj.dataArray(filter, :);
end