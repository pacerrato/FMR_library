function normalize(obj, columnName)
%NORMALIZE - Set the gain mean to zero
%   This FMR-Library function removes the mean of the gain data for
%   each value of the column cName. 
%
%   Syntax
%     NORMALIZE(obj, cName)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     cName - Name of the cut column
%       character vector | string scalar
arguments
    obj (1,1) FMR_library.RawData
    columnName {mustBeTextScalar}
end
    % Get columnName data column
    columnData = obj.getDataColumn(columnName);
    uniqueData = unique(columnData);

    % Normalize gain on each subset of columnName
    for colVal = uniqueData'
        filterColIdx = obj.getFilter(columnData, colVal);

        gainData = obj.dataArray(filterColIdx, obj.gainIdx);

        obj.dataArray(filterColIdx, obj.gainIdx) = normalize(gainData, "center");
    end
end