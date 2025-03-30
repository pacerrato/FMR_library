function plotRangeCallback(obj,src,~)
%PLOTRANGECALLBACK Plot range field edit callback
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
        src.String = string(obj.defaultRangeMult);
    else
        src.String = num2str(num);
    end
    obj.rightButtonFcn(obj); 
end