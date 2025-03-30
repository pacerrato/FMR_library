function mustNotBeNanOrInf(A)
%MUSTBEVALIDROW Validate that input is not NaN or infinite value
%   This FMR-Library function throws an error if input is NaN or
%   infinite.
%
%   Syntax
%     MUSTBEVALIDROW(obj, A)
%
%   Input Arguments
%     A - Array
%       scalar | vector
arguments
    A {mustBeNumericOrLogical}
end
    if anynan(A)
        error("NaN element was found.");
    end

    if any(isinf(A))
        error("Non finite element was found.")
    end
end