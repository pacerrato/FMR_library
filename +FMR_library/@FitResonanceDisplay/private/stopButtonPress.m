function stopButtonPress(obj,~,~)
%STOPBUTTONPRESS Stop button callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    ~
    ~ 
end
    % Update visual information
    obj.stopButton.Visible = 'off';
    updateButtonStatus(obj);
end    