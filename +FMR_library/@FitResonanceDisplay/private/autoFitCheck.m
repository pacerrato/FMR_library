function autoFitCheck(obj,src,~)
%AUTOFITCHECK Automatic fit checkbox callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    src (1,1) {mustBeUnderlyingType(src, 'matlab.ui.control.UIControl')}
    ~ 
end
% Enable or disable autofit panel
    if (src.Value)
        obj.rangeMultField.Enable = 'on';
        obj.minRsqrField.Enable = 'on';
    else
        obj.rangeMultField.Enable = 'off';
        obj.minRsqrField.Enable = 'off';
    end
end