function formatFitAxes(obj, dataObject)
%FORMATFITAXES Format the axes of the UI
%   Set title and labels of both axes.
    arguments
        obj (1,1) FMR_library.FitResonanceDisplay
        dataObject (1,1) FMR_library.RawData
    end

    % Get axes handles
    leftAxes = obj.axesArray(1);
    rightAxes = obj.axesArray(2);

    % Get the name of x variable
    if (strcmp(obj.cutVariable, "Frequency"))
        xVar = "Field";
        xVarUnits = dataObject.fieldUnits;
    else
        xVar = "Frequency";
        xVarUnits = dataObject.frequencyUnits;
    end

    % Axes titles
    title(leftAxes, "Current data to fit", ...
                    "FontUnits", "normalized", ...
                    "FontSize", 0.05);
    title(rightAxes, "Fit", ...
                     "FontUnits", "normalized", ...
                     "FontSize", 0.05);

    % Axes labels
    xlabel(leftAxes,strjoin([xVar," (",xVarUnits,")"],""), ...
                            "FontUnits", "normalized", ...
                            "FontSize", 0.035);
    xlabel(rightAxes,strjoin([xVar," (",xVarUnits,")"],""), ...
                             "FontUnits", "normalized", ...
                             "FontSize", 0.035);
    ylabel(leftAxes,strjoin(["Gain (",dataObject.gainUnits,")"], ""), ...
                             "FontUnits", "normalized", ...
                             "FontSize", 0.035);
end