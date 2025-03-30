function counterCallback(obj,src,~)
%COUNTERCALLBACK Counter field edit callback
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
        src.String = num2str(obj.currentIdx);
    else
        src.String = num2str(round(num));
        obj.currentIdx = round(num);
    end

    updateButtonStatus(obj);

    % Execute counter callback function
    obj.counterCallbackFcn(obj);
end