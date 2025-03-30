function [xData, yData] = getResonancePlotData(obj, cutVar, filterValue)
%GETRESONANCEPLOTDATA - Get the gain and swept variable data
%   This FMR-Library function returns the swept variable data and the
%   gain data for a given value of the cut variable.
%
%   Syntax
%     [xData,yData] = GETRESONANCEPLOTDATA(obj,cutVar,currentValue)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     cutVar - Cut variable
%       "Frequency" | "Field"
%     filterValue - Value of the cut variable
%       double       
%
%   Output Arguments
%     xData - Swept variable data
%       n-by-1 vector
%     yData - Gain data
%       n-by-1 vector
%
%   Examples
%     [xData,yData] = GETRESONANCEPLOTDATA(obj,"Frequency",3.2)
%       This example returns the field data and gain data such that
%       the frequency is equal to 3.2 (frequency units).
arguments
    obj (1,1) FMR_library.RawData {mustHaveAllColumns(obj)}
    cutVar {mustBeTextScalar}
    filterValue (1,1) {mustBeNumeric}
end
    % Get x and y data such that cutVariable == currValue
    xData = obj.getDataSubset(cutVar, filterValue);
    yData = xData(:, obj.gainIdx);
    xData(:,[obj.getDataColumnIdx(cutVar), obj.gainIdx]) = [];
end