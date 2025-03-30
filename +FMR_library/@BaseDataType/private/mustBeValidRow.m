function mustBeValidRow(obj, A)
%MUSTBEVALIDROW Validate that input array are valid indices
%   This FMR-Library function throws an error if input array
%   has indices out of bounds of current data array.
%
%   Syntax
%     MUSTBEVALIDROW(obj, A)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     A - Row indices
%       scalar | vector
arguments
    obj (1,1) FMR_library.BaseDataType
    A {mustBeVector, mustBeNumericOrLogical, mustNotBeNanOrInf(A)}
end
    if islogical(A)
        [~, maxIdx] = max(A .* (1:numel(A)));
        if maxIdx > obj.nRows
            error("Logical indices contain a true value outside of the array bounds.")
        end
        return
    end

    if any(rem(A, 1) ~= 0)
        error("Non integer index was found.")
    end

    if any(A < 1) || any(A > obj.nRows)
        error("One or more indices are outside of the array bounds.")
    end
end