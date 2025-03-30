function [D, c] = getCutData(obj)
%GETCUTDATA - Get cut variable data column
%   This FMR-Library function returns the data column of cut variable.
% 
%   Syntax
%     D = GETCUTDATA(obj)
%
%     [D, c] = GETCUTDATA(obj)
%
%   Input Arguments
%     obj - FMR data object
%       FMRData object
%
%   Output Arguments
%     D - Data
%       n-by-1 vector
%     c - Cut variable
%       string | character vector
arguments
    obj (1,1) FMR_library.FMRData
end
    if strcmp(obj.sweptMagnitude, "Field")
        D = obj.getDataColumn("Frequency");
        c = "Frequency";
    else
        D = obj.getDataColumn("Field");
        c = "Field";
    end
end