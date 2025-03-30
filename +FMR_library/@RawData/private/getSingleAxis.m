function ax = getSingleAxis()
%GETSINGLEAXIS - Get an axes object with box and grid
%   This FMR-Library function returns an axes object with box and grid.
%
%   Syntax
%     ax = GETSINGLEAXIS()
%
%   Output Arguments
%     ax - Axes handle
%       Axes object
    fig = figure();
    ax = axes('Parent',fig);

    % Format the axes
    box(ax, "on");
    grid(ax, "on");
end

        