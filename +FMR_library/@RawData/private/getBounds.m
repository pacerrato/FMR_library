function B = getBounds(obj, cName)
%GETBOUNDS - Get the bounds of a column
%   This FMR-Library function returns the minimum and maximum value of
%   a column.
%
%   Syntax
%     B = GETBOUNDS(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     cName - Column name
%       character vector | string scalar
%
%   Output Arguments
%     B - Bounds of column
%      1-by-2 vector
arguments
    obj (1,1) FMR_library.RawData
    cName {mustBeTextScalar}
end
    column = obj.getDataColumn(cName);
    B = [min(column), max(column)];
end