function C = cropDataToBoundaries(data, xlims)
%CROPDATATOBOUNDARIES - Crop data to given first column limits
%   This FMR-Library function crops a two column matrix of data
%   to the boundaries set on the first column.
%
%   Syntax
%     C = CROPDATATOBOUNDARIES(data, xlims)
%
%   Input Arguments
%     data - Data array
%       matrix
%     xlims - Boundaries of first column
%       2 element vector
%
%   Output Arguments
%     C - Cropped data
%       matrix
arguments
    data {mustBeNumeric, mustBeMatrix}
    xlims {mustBeNumeric, mustBeVector}
end
    % Find closest indices to xlims
    [~, idx1] = min(abs(data(:,1) - xlims(1)));
    [~, idx2] = min(abs(data(:,1) - xlims(2)));

    % Crop data
    if (idx1 < idx2)
        C = data(idx1:idx2, :);
    else
        C = data(idx2:idx1, :);
    end
end