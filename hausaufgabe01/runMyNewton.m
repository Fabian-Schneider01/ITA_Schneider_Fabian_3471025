% Description - Runs the Newton Algorithm for calculating the zero crossings of a function. 
%
% Reference - Description of myNewton 
%
% Other m-files required: myNewton.m
% Subfunctions: -
% MAT-files required: -
%
% See also: myNewton.m, runMyNewton, myPoly.m, dmyPoly.m

% Author: Fabian Schneider
% matriculation number: 3471025
% email: inf20182@lehre.dhbw-stuttgart.de
% Repository: https://github.com/Fabian-Schneider01/ITA_Schneider_Fabian_3471025.git
% Date: 03-April-2022

%------------- BEGIN CODE --------------

[xZero, abortFlag, iters] = myNewton('function', @myPoly, 'startValue', 5, 'livePlot', 'on');

%------------- END OF CODE --------------