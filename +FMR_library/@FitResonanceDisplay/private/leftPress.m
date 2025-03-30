function leftPress(obj,~,~)
%LEFTPRESS Press left button callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    ~ 
    ~ 
end
    % Update currentIdx and update buttons
    obj.changeCurrentIdx(-obj.step);
    updateButtonStatus(obj);

    % Set the counter
    obj.setCounter;

    % Execute left button action
    obj.leftButtonFcn(obj);
end