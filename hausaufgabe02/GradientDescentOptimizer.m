% GradientDescentOptimizer
%
% Syntax:  obj = GradientDescentOptimizer(varargin);
%
% Properties:
%   --PRIVATE--
%   costHistory - History of all Costs
%   learningRate - Analyzing this function
%   maxIterations - Maximum Ammount of Iterations
%
% Methods:
%   --PUBLIC--
%   GradientDescentOptimizer(varargin) - Creating Instance of the Class
%   runTraining(obj, linearRegressionModel) - Running the Training
%   showTrainingResult(obj) - Visualizing Training Result
%   setLearningRate(obj, alpha) - Setting Value of Learning Rate
%   setMaxNumOfIterations(obj, maxIters) - Setting the Value for Maximum Iterations
%   --PRIVATE
%   [alpha,maxIters,theta,X,y,m,costOverIters] = getLocalsForTraining(obj,linearRegressionModel) - Returning Locals for Training
%
% Example: 
%   obj = GradientDescentOptimizer('LearningRate',9e-6,'MaxIterations',1e7);
%
% Other m-files required: LinearRegressionDataFormatter.m LinearRegressionModel.m runScript.m
% 
% Subfunctions: -
% MAT-files required: TemperatureMeasurement.mat
%
% See also: LinearRegressionModel.m LinearRegressionDataFormatter.m runScript.m
%
%
% Author: Fabian Schneider
% Matriculation number: 3471025
% Email: inf20182@lehre.dhbw-stuttgart.de
% Repository: https://github.com/Fabian-Schneider01/ITA_Schneider_Fabian_3471025.git
% Date: 10-April-2022

%------------- BEGIN CODE --------------

classdef GradientDescentOptimizer < matlab.mixin.SetGet
    % Class to perform the training for a lineare regression Model
      
    properties (Access = private)
        costHistory
        learningRate
        maxIterations
    end
    
    methods (Access = public)
        function obj = GradientDescentOptimizer(varargin)
            % Construct an instance of this class 
            % Performing the varargin
            for i=1:max(size(varargin))
                switch varargin{i}
                    case{'LearningRate'}
                        obj.learningRate = varargin{i+1};
                    case{'MaxIterations'}
                        obj.maxIterations = varargin{i+1};
                end
            end
            
        end

        function h = runTraining(obj, linearRegressionModel)
            [alpha,maxIters,theta,X,y,m,costOverIters] = obj.getLocalsForTraining(linearRegressionModel);
            % Looping over theta-update-rule
            for i=1:maxIters
                % Vectorized updaterule
                theta = theta - (alpha/m*(ctranspose(X)*(linearRegressionModel.hypothesis()-y)));
                % Updating theta property of linearRegressionModel
                linearRegressionModel.setTheta(theta(1), theta(2));
                % Computing current costs and saving them in costOverIters
                costOverIters(i) = linearRegressionModel.costFunction();
            end 
            
            obj.costHistory = costOverIters;
            linearRegressionModel.setThetaOptimum(theta(1),theta(2));
            h = obj.showTrainingResult();
        end
        
        function h = showTrainingResult(obj)
           h = figure('Name','Costs over Iterations during training');
           plot(obj.costHistory,'x-');
           xlabel('Iterations'); ylabel('costs');
           grid on;
           xlim([2500 obj.maxIterations]);
        end
        
        function setLearningRate(obj, alpha)
           obj.learningRate = alpha;
        end
        
        function setMaxNumOfIterations(obj, maxIters)
            obj.maxIterations = maxIters;
        end
    
    end
    
    methods (Access = private) 
       function [alpha,maxIters,theta,X,y,m,costOverIters] = getLocalsForTraining(obj,linearRegressionModel)
            m = linearRegressionModel.trainingData.numOfSamples;
            theta = linearRegressionModel.theta;
            X = [ones(m,1) linearRegressionModel.trainingData.feature];
            alpha = obj.learningRate;
            y = linearRegressionModel.trainingData.commandVar;
            costOverIters = zeros(obj.maxIterations, 1);
            maxIters = obj.maxIterations;
        end 
    end
end

%------------- END OF CODE --------------