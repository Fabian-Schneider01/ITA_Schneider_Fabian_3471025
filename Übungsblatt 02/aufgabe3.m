importdata SurfData.mat

surf(X,Y,Z,'FaceAlpha', 0.5);
zlabel('y*sin(x)-x*cos(y)', 'FontSize', 15);
title('Two surf plots', 'FontSize', 18);