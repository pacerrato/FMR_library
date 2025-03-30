function P = getPointsFromPlot(obj, ax, opts)
%GETPOINTSFROMPLOT - Extract points from a plot by clicking on them
%   This FMR-Library function returns an array with the x and y
%   coordinates of the points that the user clicks. By setting the
%   option GetClosestData to true and specifying the x and y data
%   columns, the array will be formed of closest data points to
%   user input.
%
%   Syntax
%     P = GETPOINTSFROMPLOT(obj, ax)
%     P = GETPOINTSFROMPLOT(___,Name,Value)
%
%   Input Arguments
%     obj - Data object
%       RawData object
%     ax - Axes handle of plot to get points from
%       Axes object | PolarAxes object | GeographicAxes object
%
%   Name-Value Arguments
%     GetClosestData - Find closest data points to user input
%       false (default) | true
%     xDataName - Name of column storing X-axis data
%       character vector | string scalar
%     yDataName - Name of column storing Y-axis data
%       character vector | string scalar
%
%   Output Arguments
%     P - Input points
%       matrix
arguments
    obj (1,1) FMR_library.RawData
    ax (1,1) {mustBeUnderlyingType(ax,'matlab.graphics.axis.Axes')}
    opts.GetClosestData (1,1) logical = false
    opts.xDataName {mustBeTextScalar}
    opts.yDataName {mustBeTextScalar}
end

    P = [];
    % Get user input
    while true
        try
            % Read data
            [x, y] = ginput(1);

            % If user presses ENTER, exit
            if (isempty(x))
                break
            end

            % Place point on plot
            hold(ax, "on");
            plot(ax, x, y, '.', 'Color', 'black');
            hold(ax, "off");
            P = [P; x, y]; %#ok<AGROW>
        catch
            break;
        end
    end

    % Find closest data points to selection
    if (opts.GetClosestData)
        % Get column data
        xData = obj.getDataColumn(opts.xDataName);
        yData = obj.getDataColumn(opts.yDataName);
        data = [xData, yData];

        % Find index of closest point to user input
        % distMatrix = pdist2(inputPoints, data);
        [~, pointsIdx] = min(distMatrix, [], 2);
        
        % Substitute data
        P = data(pointsIdx, :);
    end
end