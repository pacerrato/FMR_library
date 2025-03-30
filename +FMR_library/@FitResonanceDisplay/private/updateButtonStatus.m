function updateButtonStatus(obj)
%UPDATEBUTTONSTATUS Update the button display
    arguments
        obj (1,1) FMR_library.FitResonanceDisplay
    end

    % If fit mode is activated
    if (obj.isFittingData)
        obj.fitButton.Visible = 'off';
        obj.stopButton.Visible = 'on';
        obj.saveButton.Enable = 'off';
        obj.deleteButton.Enable = 'off';

        obj.rightArrow.Enable = 'off';
        obj.leftArrow.Enable = 'off';
    else
        obj.fitButton.Visible = 'on';
        obj.stopButton.Visible = 'off';
        obj.saveButton.Enable = 'on';
        obj.deleteButton.Enable = 'on';
    
        % Check if current index is at limit 
        % and update Enable property
        if (obj.currentIdx == obj.nCuts)
            if (obj.step > 0)
                obj.rightArrow.Enable = 'off';
            else
                obj.leftArrow.Enable = 'off';
            end
        else 
            obj.rightArrow.Enable = 'on';
            obj.leftArrow.Enable = 'on';
        end
        if (obj.currentIdx == 1)
            if (obj.step > 0)
                obj.leftArrow.Enable = 'off';
            else
                obj.rightArrow.Enable = 'off';
            end
        else
            obj.rightArrow.Enable = 'on';
            obj.leftArrow.Enable = 'on';
        end
    end            
end