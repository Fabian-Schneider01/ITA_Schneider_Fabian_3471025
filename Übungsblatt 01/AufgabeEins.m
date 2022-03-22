%% define matrices

A = [1 2 3-4i; -1 0 17];
B = [-1 6 101; 12 70+1i 99];
I = eye(3);
c = [-1 12+2i, 0-12i];

%% calculations

disp(A+B); %%a)
%%disp(I*B); %%b) => Error, da Spalten A != Zeilen B
disp(B+(A*I)); %%c)
%%disp(transpose(I*B)); %%d) => Error, da Spalten I != Zeilen B
disp(c+B); %%e) 
disp(I*(transpose(B*I))); %%f)
disp(2*B*(I.*c)); %%g) geht mit ".*" 
disp(B.*c+A); %%h)geht mit ".*"
disp(transpose(I*transpose(A)*(B.*c))); %%i) geht mit ".*"
