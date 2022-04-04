function yVal = numDiff(funct,xVal,algorithm)
% numDiff - Calculates the dericative of a function
%
% Syntax:  numDiff(funct,xVal,algorithm)
%
% Inputs:
%    funct - Finding Zero crossings of this function 
%    xVal - Calculating the derivative at this value
%    algorithm - Chosen method for calculating the derivative
%
% Outputs:
%    yVal - Derivative of function at x value
%
% Example: 
%    yVal = numDiff(func, 5, 'forward')
%
% Other m-files required: -
% Subfunctions: -
% MAT-files required: -
% See also: myNewton.m, runMyNewton.m, myPoly.m, dmyPoly.m

% Author: Fabian Schneider
% matriculation number: 3471025
% email: inf20182@lehre.dhbw-stuttgart.de
% Repository: https://github.com/Fabian-Schneider01/ITA_Schneider_Fabian_3471025.git
% Date: 04-April-2022

%------------- BEGIN CODE --------------

switch algorithm
    case 'forward'
        yVal = (funct(xVal) - funct(xVal - 1e-8)) / 1e-8;
    case 'central'
        yVal = (funct(xVal + 1e-6) - funct(xVal - 1e-6)) / (2*1e-6);
    case 'backward'
        yVal = (funct(xVal + 1e-8) - funct(xVal)) / 1e-8;
    otherwise
        error("Error: No algorithm could be chosen. Try again");
end
end

%------------- END OF CODE --------------