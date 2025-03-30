function B = getBounds(data)
%GETBOUNDS - Get the bounds of a column
%   This FMR-Library function returns the minimum and maximum value of
%   a column.
%
%   Syntax
%     B = GETBOUNDS(obj, v)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     data - data
%       vector
%
%   Output Arguments
%     B - Bounds of column
%      1-by-2 vector
arguments
    data {mustBeNumeric, mustBeVector}
end
    B = [min(data), max(data)];
end