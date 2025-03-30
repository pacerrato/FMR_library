function mustBeAppendable(obj, data)
%MUSTBEAPPENDABLE Validate that the input is the right size to append to existing data
%   This FMR-Library function throws an error if input is not a column
%   or if input does not have the same number of rows as previously
%   existing data.
%
%   Syntax
%     MUSTBEAPPENDABLE(obj, data)
%
%   Input Arguments
%     obj - Data object
%       BaseDataType object
%     data - Input data
%       n-by-1 array
arguments
    obj (1,1) FMR_library.BaseDataType
    data {mustBeColumn}
end
    if (size(data, 1) ~= obj.nRows && obj.nRows ~= 0)
        error("Incompatible size. Input array cannot be appended.")
    end
end

