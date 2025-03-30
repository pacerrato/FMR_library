function summary(obj)
%SUMMARY - Display summary of contents of object
%   This FMR-Library function displays a summary of the contents of
%   the object. It shows the number of columns, their names and the
%   number of rows.
%
%   Syntax
%     SUMMARY(obj)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
arguments
    obj (1,1) FMR_library.BaseDataType
end
    disp(['DATA SUMMARY', newline, ...
          'There are ', num2str(obj.nRows), ...
          ' rows and ', num2str(obj.nColumns), ...
          ' columns of data stored. Column names are:']);
    disp(strjoin(obj.columnNames, ', '));
end