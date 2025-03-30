function detrend(obj, cName, ws)
%DETREND - Remove the trend of gain
%   This FMR-Library function removes the trend in the gain data for
%   each value of the column cName. The function makes an approximation
%   of the local shape of the function using a quadratic Savitzky–Golay
%   filter with a window size of ws * numel(data). Then, the smoothed
%   function is subtracted from the data. 
%
%   For each value of the column cName, the swept variable must be sorted.
%
%   Syntax
%     DETREND(obj, cName)
%     DETREND(obj, cName, ws)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     cName - Name of the cut column
%       character vector | string scalar
%     tol - Window size relative to total data points
%       0.2 (default) | numeric scalar between 0 and 1
%
%   Example
%     DETREND(obj, "Frequency")
%       Detrends the gain data for each value of frequency with a window
%       size of 20% of the length of data.
%     DETREND(obj, "Frequency", 0.1)
%       Detrends the gain data for each value of frequency with a window
%       size of 10% of the length of data. This results in a much better
%       approximation of the smooth function to the real data. A very low
%       value of ws may result in important data peaks desappearing, but
%       a very high value of ws may do nothing to background noise.
arguments
    obj (1,1) FMR_library.RawData
    cName {mustBeTextScalar}
    ws (1,1) {mustBeNumeric, mustBeInRange(ws,0,1)} = 0.2
end
    % Get column data
    columnData = obj.getDataColumn(cName);
    uniqueData = unique(columnData);

    if strcmp(cName, "Frequency")
        smoothWindowSize = floor(obj.nFields * ws);
    else
        smoothWindowSize = floor(obj.nFrequencies * ws);
    end
    % Detrend gain on each subset of columnName
    for colVal = uniqueData'
        % Get filter
        filterColIdx = obj.getFilter(columnData, colVal);

        % Get gain data
        gainData = obj.dataArray(filterColIdx, obj.gainIdx);

        % Detrend and replace gain data
        smoothGainData = smoothdata(gainData, "sgolay", smoothWindowSize);

        obj.dataArray(filterColIdx, obj.gainIdx) = gainData - smoothGainData;
    end
end