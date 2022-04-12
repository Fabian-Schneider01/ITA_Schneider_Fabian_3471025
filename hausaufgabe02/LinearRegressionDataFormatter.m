% LinearRegressionDataFormatter
%
% Syntax:  obj = LinearRegressionDataFormatter(varargin);
%
% Properties:
%   --PUBLIC--
%   feature - Feature object
%   featureName - Name of feature
%   commandVar - Command variable
%   commandVarName - Name of command variable
%   numOfSamples - Sample rate
%
%   --PRIVATE--
%   data - data object
%
% Methods:
%   --PUBLIC--
%   LinearRegressionDataFormatter(varargin) - Creating Instance of the Class
%   
%   --PRIVATE
%   mapFeature(obj) - Loading Feature from Data
%   mapCommandVar(obj) - Loading Command Var from Data
%   mapNumOfSamples(obj)- Maximum Size of feature
%
% Example: 
%   obj = LinearRegressionDataFormatter('Data','TempearatureMeasurement.mat', 'Feature','T3','CommandVar','T4');
%
% Other m-files required: GradientDescentOptimizer.m LinearRegressionModel.m runScript.m
% 
% Subfunctions: -
% MAT-files required: TemperatureMeasurement.mat
%
% See also: GradientDescentOptimizer.m LinearRegressionDataFormatter.m runScript.m
%
%
% Author: Fabian Schneider
% Matriculation number: 3471025
% Email: inf20182@lehre.dhbw-stuttgart.de
% Repository: https://github.com/Fabian-Schneider01/ITA_Schneider_Fabian_3471025.git
% Date: 10-April-2022

%------------- BEGIN CODE --------------

classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
    % Class to model the training data for lineare
    % regression model object
   
    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
            % Construct an instance of this class
            % Performing the varargin
            for i=1:max(size(varargin))
                switch varargin{i}
                    case{'Data'}
                        obj.data = load(varargin{i+1}).measurement;
                    case{'Feature'}
                        obj.featureName = varargin{i+1};
                    case{'CommandVar'}
                        obj.commandVarName = varargin{i+1};
                end
            end
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
           obj.numOfSamples = length(obj.feature); 
        end
    end
end

%------------- END OF CODE --------------