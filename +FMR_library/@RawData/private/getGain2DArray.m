function A = getGain2DArray(obj)
%GETGAIN2DARRAY - Get the gain data in a 2D array
%   This FMR-Library function returns the gain data in a 2D array, where
%   each row corresponds to a frequency and every column to a field.
%
%   Syntax
%     A = GETGAIN2DARRAY(obj)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%
%   Output Arguments
%     A - Gain 2D array
%       matrix
arguments
    obj (1,1) FMR_library.RawData {mustHaveAllColumns(obj)}
end
    A = sortrows(obj.dataArray, [obj.fieldIdx, obj.frequencyIdx]);
    if (size(A,1) ~= obj.nFrequencies * obj.nFields)
        A = obj.fillArray(A);
    else
        A = reshape(A(:, obj.gainIdx), [obj.nFrequencies, obj.nFields]);
    end
end