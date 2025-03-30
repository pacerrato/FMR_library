function fitButtonPress(obj,~,~)
%FITBUTTONPRESS Fit button press callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    ~
    ~ 
end
    % Update visual information
    obj.stopButton.Visible = 'on';
    updateButtonStatus(obj);

    % Call fit function
    fitSuccess = obj.fitButtonFcn(obj);

    % If autoFit == true go to the next plot
    while (obj.autoFit && obj.isFittingData && fitSuccess)
        obj.rightPress;
        fitSuccess = obj.fitButtonFcn(obj);
    end

    % Reset parameters
    obj.lastInitialParams = [];
    obj.stopButtonPress;
end