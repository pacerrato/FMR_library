function mustHaveAllColumns(obj)
%MUSTHAVEALLCOLUMNS Validate that the object has all columns
%   This FMR-Library function throws an error if the object does not
%   have any of the following columns: 'Frequency', 'Field', 'Gain'.
%
%   Syntax
%     MUSTHAVEALLCOLUMNS(obj)
%
%   Input Arguments
%     obj - Data object
%       RawData object
arguments
    obj (1,1) FMR_library.RawData
end
    if any(~ismember(obj.validColumnNames, obj.columnNames))
        error(strjoin(["Not enough data to execute this function. Necessary columns are:", obj.validColumnNames]))
    end
end

