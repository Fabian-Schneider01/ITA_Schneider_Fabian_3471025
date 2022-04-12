% LinearRegressionModel
%
% Syntax:  obj = LinearRegressionModel(varargin);
%
% Properties:
%   --PUBLIC
%   optimizer - Instance of GradientDescentOptimizer
%   trainingData - Containing Training Data 
%   theta - Current Theta Value
%   thetaOptimum - Optimum Theta Value
%
% Methods:
%   --PUBLIC--
%   LinearRegressionModel(varargin) - Creating Instance of the Class
%   costFunction(obj) - Computing the costs
%   hypothesis(obj) - Computing the hypothesis
%   calcCost(obj, theta0_vals, theta1_vals) - computing the costs for each theta_vals tuple
%   showOptimumInContour(obj) - Plotting the Contour of Costs 
%   showCostFunctionArea(obj) - Plotting the Area of Costs
%   showTrainingData(obj) - Plotting the Training Data
%   showModel(obj) - Plotting the final trained Data to the figure 
%   setTheta(obj,theta0,theta1) - Setting Theta 
%   setThetaOptimum(obj,theta0,theta1) - Setting optimal Theta
%
%   --PRIVATE
%   initializeTheta(obj) - Initializing Theta
%
% Example: 
%    obj = LinearRegressionModel('Data',dataForLinearRegression,'Optimizer',gradientDescentOptimizer);
%
% Other m-files required: GradientDescentOptimizer.m LinearRegressionDataFormatter.m runScript.m
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

classdef LinearRegressionModel < matlab.mixin.SetGet
    % Class representing an implementation of linear regression model
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            % Constructing an instance of this class
            % Performing the varargin
            for i=1:max(size(varargin))
                switch varargin{i}
                    case {'Data'}
                        obj.trainingData = varargin{i+1};
                    case {'Optimizer'}
                        obj.optimizer = varargin{i+1};
                end
            end
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            % Computing the costs by using the hypothesis function
            m = obj.trainingData.numOfSamples; 
            % Returning the calculated cost value J 
            J = (1/(2*m))* sum(power(obj.hypothesis() - obj.trainingData.commandVar, 2));
        end
        
        function hValue = hypothesis(obj)
            % Computing the hypothesis values for each sample 
            hValue = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature] * obj.theta;
        end
        
        function cost = calcCost(obj, theta0_vals, theta1_vals)
            % Computing the costs for each theta_vals tuple
            cost = zeros(max(size(theta0_vals)), max(size(theta1_vals)));
            for i = 1:max(size(theta0_vals))
                for o = 1:max(size(theta1_vals))
                    obj.setTheta(theta0_vals(i), theta1_vals(o));
                    cost(o, i) = obj.costFunction();
                end
            end
        end

        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            % Computing the costs for each theta_vals tuple
            cost = calcCost(obj, theta0_vals, theta1_vals);
            % Plotting the costs with the contour command
            contour(theta0_vals, theta1_vals, cost);
            % Adding X and Y label
            xlabel('\theta_0');
            ylabel('\theta_1');
            hold on
            % Adding the optimum theta value to the plot
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
                       
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            % Computing the costs for each theta_vals tuple
            cost = calcCost(obj, theta0_vals, theta1_vals);
            % Plotting the costs with the surf command
            surf(theta0_vals, theta1_vals, cost);
            % Adding X and Y label
            xlabel('\theta_0');
            ylabel('\theta_1');
            
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           hold on;
           % Plotting the final trained Data to the figure ('b-')
           plot(obj.trainingData.feature,obj.hypothesis, 'b-');
           % Updating the Legend
           legend('Training Data','Linear Regression Model')
           hold off;
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end

%------------- END OF CODE --------------
