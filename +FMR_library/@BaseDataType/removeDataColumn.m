function removeDataColumn(obj, cName)
%REMOVEDATACOLUMN - Remove a column from data array
%   This FMR-Library function removes a column from the data array.
%
%   Syntax
%     REMOVEDATACOLUMN(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Column name
%       numeric scalar
%     
%   Output Arguments
%     F - Filter
%       sparse vector
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustBeVector, mustExistColumnName(obj, cName)}
end
    columnIdx = obj.getDataColumnIdx(cName);
    obj.dataArray(:, columnIdx) = [];
    obj.columnNames(columnIdx) = [];
    obj.nColumns = obj.nColumns - numel(columnIdx);
    
    if obj.nColumns == 0
        obj.nRows = 0;
        obj.dataArray = [];
    end
end

