function F = getFilter(A, x)
%GETFILTER - Get a logical array for indices that A == x
%   This FMR-Library function returns a logical sparse vector that 
%   has a logical 1 in places where A == x.
%
%   Syntax
%     F = GETFILTER(A, x)
%
%   Input Arguments
%     A - Input array
%       scalar | vector
%     x - Filter value 
%       numeric scalar
%     
%   Output Arguments
%     F - Filter
%       sparse vector
arguments
    A {mustBeNumeric, mustBeVector}
    x (1,1) {mustBeNumeric}
end
    F = sparse(A == x);
end