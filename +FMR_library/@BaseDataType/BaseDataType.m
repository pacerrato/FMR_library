classdef (Abstract) BaseDataType < handle
    %BASEDATATYPE - Base class for data storage
    %   BaseDataType is the abstract base class for the storage and
    %   manipulation of experimental data. This class allows storage
    %   and easy manipulation of data.
    %
    %   BaseDataType Properties:
    %     nColumns    - Number of columns of data
    %     nRows       - Number of rows of data
    %     columnNames - Names of the columns
    %     dataArray   - Array of data
    %
    %   BaseDataType Methods:
    %     addData          - Add column to the data array
    %     getDataColumn    - Get a column of the data array
    %     getDataColumnIdx - Get the index of a column
    %     getDataSubset    - Get data subset for a filter value
    %     getFilter        - Get a logical array for indices equal to a filter value
    %     removeDataColumn - Remove a column from data array
    %     removeDataRow    - Remove row from data array
    %     renameDataColumn - Rename a column from data array
    %     summary          - Display summary of contents of object
    properties (GetAccess = public, SetAccess = protected)
        % Number of columns of data
        nColumns    (1,1) {mustBeNumeric} = 0;
        % Number of rows of data
        nRows       (1,1) {mustBeNumeric} = 0;
        % Name of data columns
        columnNames {mustBeText} = strings(0);
        % Data array
        dataArray   (:,:) = [];
    end
    
    properties (Abstract, Constant)
        % Allowed names for columns
        validColumnNames {mustBeVector, mustBeText}
    end

    methods
        function obj = BaseDataType()
        end
    end
    
    methods (Access = public)
        summary(obj)

        addData(obj, cName, cData, rplc)

        removeDataColumn(obj, cName)

        removeDataRow(obj, A)

        renameDataColumn(obj, cName, newName)

        I = getDataColumnIdx(obj, cName)

        C = getDataColumn(obj, cName)

        S = getDataSubset(obj, cName, x)
    end

    methods (Static)
        filter = getFilter(A, x)
    end
end