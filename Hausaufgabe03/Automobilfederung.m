%% Automobilfederung
%
% Syntax:  obj = Automobilfederung(varargin);
%
% Properties:
%   c1 - first spring constant
%   c2 - second spring constant
%   d2 - damping constant
%   m1 - mass one
%   m2 - mass two
%   u - input vector
%   A - interference matrix [2x4 double]
%   B - dynamics matrix [3x1 double]
%   tsimout - for t-axis
%   ysimout - for y-axis
%
% Methods:
%   --PUBLIC--
%   Automobilfederung(varargin) - Constructor
%   sim(obj, varargin) - Calculating results
%   visualizeResults(obj) - Plotting results
%   
%   --PRIVATE
%   calcInputMatixB(obj) - Calculating interferenc matrix
%   calcSystemMartixA(obj) - Calculating the dynmics matrix
%   xdot = rhs(obj, t, x) - calculating derivative 
%
% Example: 
%   model = Automobilfederung('m1', 25, 'm2', 250, 'c1', 9e+4, 'c2', 3e+4, 'd2', 750, 'u', u);
%
% Other m-files required: runScript.m
% 
% Subfunctions: -
% MAT-files required: -
%
% See also: runScript.m
%
%
% Author: Fabian Schneider
% Matriculation number: 3471025
% Email: inf20182@lehre.dhbw-stuttgart.de
% Repository: https://github.com/Fabian-Schneider01/ITA_Schneider_Fabian_3471025.git
% Date: 11-May-2022

%------------- BEGIN CODE --------------

classdef Automobilfederung < handle

    properties
        c1 {mustBeNumeric}
        c2 {mustBeNumeric}
        d2 {mustBeNumeric}
        m1 {mustBeNumeric}
        m2 {mustBeNumeric}
        u
        A {mustBeNumeric}
        B {mustBeNumeric}
        tsimout {mustBeNumeric}
        ysimout {mustBeNumeric}
    end
    methods (Access = public)
        function obj = Automobilfederung(varargin)
            for i = 1:2:nargin
                if strcmp(varargin{i},'c1')
                    obj.c1 = varargin{i+1};
                elseif strcmp(varargin{i},'c2')
                    obj.c2 = varargin{i+1};
                elseif strcmp(varargin{i},'d2')
                    obj.d2 = varargin{i+1};
                elseif strcmp(varargin{i},'m1')
                    obj.m1 = varargin{i+1};
                elseif strcmp(varargin{i},'m2')
                    obj.m2 = varargin{i+1};
                elseif strcmp(varargin{i},'u')
                    if isa(varargin{i+1},'function_handle')
                        obj.u = varargin{i+1};
                    else
                        error("u seems not to be a function handle");
                    end
                else
                    warning("Invalid property: "+varargin{i});
                end
            end
            obj.calcSystemMartixA();
            obj.calcInputMatixB();
        end
        function sim(obj, varargin)
            t = 0;
            tfinal = 10;
            h = 0.01;
            y = [0; 0; 0; 0];
            for i = 1:2:nargin-1
                % ========= YOUR CODE HERE =========
                % perform the varargin: overwrite the defaults
                if strcmp(varargin{i},'y0')
                   y = varargin{i+1}(:);
                elseif strcmp(varargin{i},'stepsize')
                  h = varargin{i+1};
                elseif strcmp(varargin{i},'t0') 
                   t = varargin{i+1};
                elseif strcmp(varargin{i},'tfinal')
                   tfinal = varargin{i+1};
                else
                    warning("Invalid property: " + varargin{i})
                end
            end
            tout = zeros(ceil((tfinal-t)/h)+1,1);
            yout = zeros(ceil((tfinal-t)/h)+1,length(y));
            tout(1) = t;
            yout(1,:) = y';
            step = 1;
            while (t < tfinal)
                step = step + 1;
                if (t + h) > tfinal
                    % ========= YOUR CODE HERE =========
                    % calculating h
                    h = tfinal - t;
                end
                % ========= YOUR CODE HERE =========
                % calculate the slopes
                kOne = obj.rhs(t, y);
                kTwo = obj.rhs(t + h/2, y + h/2 * kOne);
                kThree = obj.rhs(t + h/2, y + h/2 * kTwo);
                kFour = obj.rhs(t + h, y + h * kThree);
                % calculate the ynew
                ynew = y + (h*kOne)/6 + (h*kTwo)/3 + (h*kThree)/3 + (h*kFour)/6;
                t = t + h;
                y = ynew;
                tout(step) = t;
                yout(step,:) = y';
                obj.tsimout = tout;
                obj.ysimout = yout;
            end
        end
        function fig = visualizeResults(obj)
            fig = figure('Name','Ergebnisse der Simulation');
            subplot(2,1,1);
            plot(obj.tsimout,obj.ysimout(:,1),'s-',...
                 obj.tsimout,obj.ysimout(:,3),'x-')
            grid on;
            ylabel('Höhe in m');
            legend('Karosserie','Rad');
            title("Position der Zustände | stepsize = "+num2str(obj.tsimout(2)-obj.tsimout(1)))
            subplot(2,1,2);
            plot(obj.tsimout,obj.ysimout(:,2),'s-',...
                 obj.tsimout,obj.ysimout(:,4),'x-')
            grid on;
            ylabel('Geschwindigkeit in m/s');
            xlabel('Simulationszeit in s');
            legend('Karosserie','Rad');
            title("Geschwindigkeit der Zustände | stepsize = "+num2str(obj.tsimout(2)-obj.tsimout(1)))
        end
    end
    methods (Access = private)
        function calcInputMatixB(obj)
            % ========= YOUR CODE HERE =========
            obj.B = [0; 0; 0; (obj.c1/obj.m1)];
        end
        function calcSystemMartixA(obj)
            % ========= YOUR CODE HERE =========
            obj.A = [0 1 0 0; (-obj.c2/obj.m2) (-obj.d2/obj.m2) (obj.c2/obj.m2) (obj.d2/obj.m2); 0 0 0 1; (obj.c2/obj.m1) (obj.d2/obj.m1) (-(obj.c1+obj.c2)/obj.m1) (-obj.d2/obj.m1)];
        end
        function xdot = rhs(obj, t, x)
            x = x(:);
            xdot = obj.A*x+ obj.B*obj.u(t);
        end
    end
end

%------------- END OF CODE --------------
