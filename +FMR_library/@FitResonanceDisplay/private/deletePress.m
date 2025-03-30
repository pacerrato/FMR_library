function deletePress(obj,~,~)
%DELETEPRESS Delete button callback
arguments
    obj (1,1) FMR_library.FitResonanceDisplay
    ~
    ~ 
end
    % Delete parameters
    obj.fitParams(obj.currentIdx,:) = nan(1,9);
    obj.uncertFitParams(obj.currentIdx,:) = nan(1,9);
    
    % Execute delete button action
    obj.deleteButtonFcn(obj);
end