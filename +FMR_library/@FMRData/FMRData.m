classdef FMRData < FMR_library.BaseDataType
    %FMRDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % 
        sweptMagnitude {mustBeTextScalar} = "Field"
        frequencyUnits {mustBeTextScalar} = "GHz"
        fieldUnits {mustBeTextScalar} = "T"
        gainUnits {mustBeTextScalar} = "dB"
        linewidthUnits {mustBeTextScalar} = ""
    end

    properties (SetAccess = private)
        % Damping parameters. First element is value and second is uncertainty
        dampingParameters struct
        % Kittel parameters. First element is value and second is uncertainty
        kittelParameters struct
    end
    
    properties (Constant)
        validColumnNames = {'Frequency', ...
                            'Field', ...
                            'LorentzianLinewidth',...
                            'GaussianLinewidth', ...
                            'Phase', ...
                            'Area', ...
                            'Offset', ...
                            'Slope', ...
                            'FieldUncertainty', ...
                            'FrequencyUncertainty', ...
                            'LorentzianLinewidthUncertainty', ...
                            'GaussianLinewidthUncertainty', ...
                            'PhaseUncertainty', ...
                            'AreaUncertainty', ...
                            'OffsetUncertainty', ...
                            'SlopeUncertainty'}
    end

    methods
        function obj = FMRData()
            %FMRDATA Construct an instance of this class
            %   Detailed explanation goes here

            % Initialize normally
            obj = obj@FMR_library.BaseDataType();
        end
    
        %--------------------------------------------%
        %                    Getters                 %
        %--------------------------------------------%

        function D = get.dampingParameters(obj)
            if (isempty(fields(obj.dampingParameters)))
                obj.fitDamping("MakePlot", false);
            end
            D = obj.dampingParameters;
        end

        function K = get.kittelParameters(obj)
            if (isempty(fields(obj.kittelParameters)))
                obj.kittelParameters = obj.fitKittel("inPlane", "MakePlot",false);
                warning("Gyromagnetic ratio not found. Fitting in plane Kittel. For reliable results, use 'fitKittel' method first.");
            end
            K = obj.kittelParameters;
        end
    end
    
    methods (Access = public)

        ax = plot(obj, xVariable, yVariable, ax)
        %--------------------------------------------%
        %                    Fitting                 %
        %--------------------------------------------%
        [kittelParams, axesHandle]= fitKittel(obj, kittelType, opts)

        [dampingParams, axesHandle] = fitDamping(obj, opts)
    end
end