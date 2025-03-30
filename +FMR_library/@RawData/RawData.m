classdef RawData < FMR_library.BaseDataType
    %RAWDATA - Class for raw data taken from experimental setup
    %   Raw data is the class where all experimental data should be
    %   loaded. This class has specialized methods to help detrend
    %   or normalize the data, to make the resonance peaks more visible.
    %   Also, there are methods to plot a 2D color image of the data and
    %   retreive points from that image. Lastly, analysis of the peaks
    %   can be done through an intuitive user interface.
    %
    %   RawData Properties:
    %     nColumns         - Number of columns of data
    %     nRows            - Number of rows of data
    %     columnNames      - Names of the columns
    %     dataArray        - Array of data
    %     validColumnNames - Allowed column names
    %     frequencyUnits   - Frequency units
    %     fieldUnits       - Field units
    %     gainUnits        - Gain units
    %
    %   RawData Methods:
    %     General methods
    %       addData           - Add column to the data array
    %       getDataColumn     - Get a column of the data array
    %       getDataColumnIdx  - Get the index of a column
    %       getDataSubset     - Get data subset for a filter value
    %       getFilter         - Get a logical array for indices equal to a filter value
    %       removeDataColumn  - Remove a column from data array
    %       removeDataRow     - Remove row from data array
    %       renameDataColumn  - Rename a column from data array
    %       summary           - Display summary of contents of object
    %
    %     Noise removal methods
    %       detrend           - Detrend the gain data
    %       normalize         - Subtract average value from gain data
    %
    %     Plot and point retreival methods
    %       plot2d            - Plot a 2D color image of the data
    %
    %     Data retreival methods
    %       getPointsFromPlot - Retreive points from plot
    %       fitResonance      - Make fit of resonance data
    properties (Access = public)
        % Frequency units
        frequencyUnits {mustBeTextScalar, mustBeValidVariableName} = "GHz";
        % Field units
        fieldUnits {mustBeTextScalar, mustBeValidVariableName} = "T";
        % Gain units
        gainUnits {mustBeTextScalar, mustBeValidVariableName} = "dB"
    end

    properties (Dependent)
        % Number of frequencies
        nFrequencies;
        % Number of fields
        nFields;
        % Frequency column index
        frequencyIdx;
        % Field column index
        fieldIdx;
        % Gain column index
        gainIdx;
    end

    properties (Constant)
        % Allowed names for columns
        validColumnNames = {'Frequency', 'Field', 'Gain'}
    end

    methods
        function obj = RawData()
            %RAWDATA Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@FMR_library.BaseDataType();
        end
    
        %--------------------------------------------%
        %                  Getters                   %
        %--------------------------------------------%

        function nFreq = get.nFrequencies(obj)
            %get.nFrequencies Get the number of different frequencies
            %   Get the number of unique frequencies

            nFreq = numel(unique(obj.getDataColumn("Frequency")));
        end
        
        function nFields = get.nFields(obj)
            %get.nFields Get the number of different fields
            %   Get the number of unique fields

            nFields = numel(unique(obj.getDataColumn("Field")));
        end

        function freqIdx = get.frequencyIdx(obj)
            %get.frequencyIdx Get the column index of frequency column
            %   Get the column index of frequency column

            freqIdx = obj.getDataColumnIdx("Frequency");
        end

        function fieldIdx = get.fieldIdx(obj)
            %get.fieldIdx Get the column index of field column
            %   Get the column index of field column

            fieldIdx = obj.getDataColumnIdx("Field");
        end

        function gainIdx = get.gainIdx(obj)
            %get.frequencyIdx Get the column index of gain column
            %   Get the column index of gain column

            gainIdx = obj.getDataColumnIdx("Gain");
        end
    end

    methods (Access = public)
        %--------------------------------------------%
        %       Data smoothing and noise removal     %
        %--------------------------------------------%

        normalize(obj, columnName)
        detrend(obj, columnName, tolerance)
        
        %--------------------------------------------%
        %                   Plotting                 %
        %--------------------------------------------%

        axesHandle = plot2d(obj, axesHandle)
        
        %--------------------------------------------%
        %               Data retreiving              %
        %--------------------------------------------%

        inputPoints = getPointsFromPlot(obj, axesHandle, opts)
        fmrData = fitResonance(obj, cutVariable)
    end
end