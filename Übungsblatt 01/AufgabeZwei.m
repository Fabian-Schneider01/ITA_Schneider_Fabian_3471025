%% define matrices

A = [1 2 3-4i; -1 0 17; -1 6 101];
c = [-1 12+2i -12i 0 1 -1 16];

%% calculations
disp(c(1:3:7)); %%a) starte bei index 1, immer um 3 nach rechts element und nicht weiter als index 7 gehen
disp(c(6:-2:1));%%b) starte bei index 6, gehe immer um -2 nach links und nicht weiter als index 1
disp(c(2:end-1));%%c) alle elemente zwischen 2 und vorletztes 
disp(A(:,1:3)); %%d) alle Zeilen und spalten elemente von 1 und 3
disp(A(2:3,3:4)); %%e) error => zeilen 2 und 3, dann spalten 3 und 4 (aber keine 4 Splaten enthalten
disp(A(:)) %%f) alle elemente, spaltenweise untereinander auflisten
%%[A;A(1:3,2)]; %%g) ??, evtl A neu befüllen
A(:,2) = []; %%h) entfernt Elemente aus der zweiten Spalte
