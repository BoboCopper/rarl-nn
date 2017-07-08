setupWorkspace;

tic

curCell = cell(1);
singleResult = cell(1);
xi = cell(1, 4);
xi{1} = 0;
xi{2} = 0;
xi{3} = 0;
xi{4} = 0;
Y_new = neural_function(X, xi);
plot(cell2mat(Y_new)); hold on; plot(Y); hold off;

toc
