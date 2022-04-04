function [xZero, abortFlag, iters] = myNewton(varargin) 
% myNewton - Runs the Newton Algorithm for calculating the zero crossings of a function. 
%
% Syntax:  [xZero, abortFlag, iters] = myNewton(varargin)
%
% Inputs:
%    function - Finding zero crossings of this function 
%    derivative - Predefined starting derivative for the function
%    startValue - X-value for start of algorithm
%    maxIter - Maximum ammount of iterations -> default 50
%    feps - Condition for termination -> default 1e-6
%    xeps - Condition for termination -> default 1e-6
%    livePlot - Live Plot for visualizing the algorithm
%
% Outputs:
%    xZero - Value which contains the ammount of zero crossings 
%    abortFlag - Condition for Terminating 
%    iters - Value which contains the ammount of iterations.
%
% Example: 
%    myNewton('function', @myPoly, 'startValue', 5, 'livePlot', 'on')
%
% Other m-files required: numDiff.m
% Subfunctions: -
% MAT-files required: -
%
% See also: numDiff.m, runMyNewton.m, myPoly.m, dmyPoly.m

% Author: Fabian Schneider
% matriculation number: 3471025
% email: inf20182@lehre.dhbw-stuttgart.de
% Repository: https://github.com/Fabian-Schneider01/ITA_Schneider_Fabian_3471025.git
% Date: 04-April-2022

%------------- BEGIN CODE --------------

%% do the varargin
for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};   
    end
end        
% Variable for tracking if a algorithm has be chosen or default algorithm
% should be used
default = false;
%% asking user for an algorithm for calculation
answer = questdlg('Wich kind of algorithm do you want to use? ', ...
        'Differentiation Picker', ...
        'Forward Difference','Backward Difference','Central Difference','Forward Difference');
    % Matching an algorithm and provide it to numDiff
    switch answer
        case 'Forward Difference'
            algorithm = 'forward';
            disp('forward algorithm chosen');
        case 'Backward Difference'
            algorithm = 'backward';
            disp('backward algorithm chosen');
        case 'Central Difference'
            algorithm = 'central';
            disp('central algorithm chosen');
        otherwise
            default = true;
            disp('using default algorithm');
    end
    

%% check for necessary parameters
if ~exist('func','var')
    error('No valid function');
end

if ~exist('x0','var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ',num2str(x0)]);
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

%% start of algorithm
if strcmp(livePlot,'on')
   h = figure('Name','Newton visualization');
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
end
xOld = x0;
abortFlag = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if f < feps
        abortFlag = 'feps';
        break;
    end

    %calculate default algorithm or chosen algorithm by user
    if default == false 
        df = numDiff(func, xOld, algorithm);   
    else 
        df = dfunc(xOld);
        
    end
    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
end

%------------- END OF CODE --------------
