tic

y_init = cell(1);
y_init{1} = 0;

Xf = cell(1);

Y_new = [];
[cols, rows] = size(X_CM);
for i = 1:rows
    curCell = cell(2,1);
    curCell{1} = X_CM(1:3, i);
    curCell{2} = y_init{1};
    [y_init, Xf] = neural_function(curCell, xis);
    Y_new = [Y_new y_init{1}];
end

toc