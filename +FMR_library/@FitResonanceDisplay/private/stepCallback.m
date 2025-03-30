function stepCallback(obj,src,~)
%STEPCALLBACK Step field edit callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    src (1,1) {mustBeUnderlyingType(src, 'matlab.ui.control.UIControl')}
    ~ 
end
    % Replace "," by "." and convert to double
    numStr = strrep(src.String, ",", ".");
    num = str2double(numStr);

    % If conversion failed, put default value
    if (isnan(num))
        src.String = string(obj.defaultStep);
    else
        src.String = num2str(round(num));
    end

    % Update button status
    obj.updateButtonStatus;
end