function changeCurrentIdx(obj, step)
%CHANGECURRENTIDX Change current index by an amount equal to "step"
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    step (1,1) {mustBeNumeric}
end
    % Update current index
    obj.currentIdx = obj.currentIdx + step;

    % If index is out of bounds, perform action
    if (obj.currentIdx > obj.nCuts)
        obj.currentIdx = obj.nCuts;
        obj.stopButtonPress;
        return
    elseif (obj.currentIdx < 1)
        obj.currentIdx = 1;
        obj.stopButtonPress;
    end
end