function mustHaveColumn(obj, cName)
%MUSTHAVEALLCOLUMNS Validate that the object has a column
%   This FMR-Library function throws an error if the object does not
%   have any of the input column names.
%
%   Syntax
%     MUSTHAVEALLCOLUMNS(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     cName - Column names
%       1-by-n cell array of character vectors | 1-by-n string array
arguments
    obj (1,1) FMR_library.RawData
    cName {mustBeVector, mustBeText}
end
    if any(~ismember(cName, obj.columnNames))
        error("This object does not have the requested column(s).")
    end
end

