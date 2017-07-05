setupWorkspace;

tic

curCell = cell(1);
singleResult = cell(1);

Y_new = [];
[cols, rows] = size(X_CM);
for i = 1:rows
    curCell{1} = X_CM(1:cols, i);
    singleResult = customFitnet(curCell);
    Y_new = [Y_new singleResult{1}];
end

toc
