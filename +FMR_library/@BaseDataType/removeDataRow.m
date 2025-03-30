function removeDataRow(obj, A)
%REMOVEDATAROW - Remove row from data array
%   This FMR-Library function removes rows from the data array.
%
%   Syntax
%     REMOVEDATAROW(obj, A)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     A - Row indices to remove
%       scalar | vector
arguments
    obj (1,1) FMR_library.BaseDataType
    A {mustBeVector, mustBeValidRow(obj,A)}
end
    obj.dataArray(A, :) = [];
    obj.nRows = obj.nRows - nnz(A);
end