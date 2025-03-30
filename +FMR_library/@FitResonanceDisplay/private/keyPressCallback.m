function keyPressCallback(obj, ~, event)
%KEYPRESSCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    switch event.Key
        case 'leftarrow',  obj.leftPress; 
        case 'rightarrow', obj.rightPress;
        case 'delete', obj.deletePress;
    end
end