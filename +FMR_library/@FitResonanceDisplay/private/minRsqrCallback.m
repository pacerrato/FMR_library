function minRsqrCallback(obj,src,~)
%MINRSQRCALLBACK Minimum r^2 edit callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    src (1,1) {mustBeUnderlyingType(src, 'matlab.ui.control.UIControl')}
    ~ 
end
    % Replace "," by "." and convert to double
    numStr = strrep(src.String, ",", ".");
    num = str2double(numStr);

    % If conversion failed, or out of range put default value
    if (isnan(num) || num >= 1 || num < 0)
        src.String = string(obj.defaultMinRsqr);
    else
        src.String = num2str(num);
    end
end