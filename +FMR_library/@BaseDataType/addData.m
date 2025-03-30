function addData(obj, cName, cData, rplc)
%ADDDATA - Add column to the data array
%   This FMR-Library function adds a new column to the data array.
%
%   Syntax
%     ADDDATA(obj, cName, cData)
%     ADDDATA(obj, cName, cData, rplc)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     cName - Name of the new column
%       character vector | string scalar
%     cData - Data column
%       n-by-1 array
%     rplc - Replace column with the same name
%       false (default) | true
arguments
    obj (1,1) FMR_library.BaseDataType
    cName {mustBeTextScalar, mustBeValidColumnName(obj,cName)}
    cData {mustBeColumn, mustBeAppendable(obj, cData)}
    rplc (1,1) logical = false
end
    % Check if a column with the same name exists
    if (ismember(cName, obj.columnNames))
        % If replaceColumn == true, delete column
        if (rplc)
            obj.removeDataColumn(cName);
        else
            warning("A column with the same name was found, if you want to replace it, set ''replaceColumn'' to true");
            return
        end
    end

    % Add column and update properties
    obj.dataArray = [obj.dataArray, cData];
    obj.columnNames = [obj.columnNames, string(cName)];
    obj.nColumns = obj.nColumns + 1;
    obj.nRows = size(cData, 1);
end