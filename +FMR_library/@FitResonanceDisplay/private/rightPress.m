function rightPress(obj,~,~)
%RIGHTPRESS Press right button callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    ~ 
    ~ 
end
    % Update currentIdx and update buttons
    obj.changeCurrentIdx(obj.step)
    updateButtonStatus(obj);

    % Set the counter
    obj.setCounter;

    % Execute right button action
    obj.rightButtonFcn(obj);
end