function F = fillArray(obj, A)
%FILLARRAY - Fill missing values in array with NaN
%   This FMR-Library function fills the missing values in the array
%   by filling them with NaN. This function is made to try and fix
%   errors in plot function. But its use is discouraged due to unexpected
%   results.
%
%   Syntax
%     F = FILLARRAY(obj, A)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     A - Array to fill
%       matrix
%
%   Output Arguments
%     F - Filled array
%       matrix
arguments
    obj (1,1) FMR_library.RawData
    A {mustBeNumeric, mustBeMatrix}
end
    warning("Data is incomplete or badly formatted. Filling missing data with NaN. Unexpected results may happen.");

    % Initialize output
    F = NaN(obj.nFrequencies, obj.nFields);

    % Get frequency and gain indices
    freqIdx = obj.frequencyIdx;
    fieldIdx = obj.fieldIdx;
    gainIdx = obj.gainIdx;

    % Loop variables initialization
    currentRow = 1;
    currentColumn = 1;
    currentField = A(1,fieldIdx);
    freqValues = unique(obj.getDataColumn("Frequency"));

    % Fill the matrix with the gain values
    for i = 1:size(A,1)
        % If a new frequency value is reached, reset column, 
        % advance row and set new current frequency.
        if (currentField ~= A(i, fieldIdx))
            currentRow = 1;
            currentColumn = currentColumn + 1;
            currentField = A(i, fieldIdx);
        end
        while (freqValues(currentRow) ~= A(i, freqIdx))
            currentRow = currentRow + 1;
        end
        % Add gain data to matrix
        F(currentRow, currentColumn) = A(i, gainIdx);
    end
end