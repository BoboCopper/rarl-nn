setupWorkspace;

tic

xi = cell(1, 4);
xi{1} = 0;
xi{2} = 0;
xi{3} = 0;
xi{4} = 0;
Y_nn_midline = neural_function_midline_reg(X, xi);
plot(cell2mat(Y_nn_midline)); hold on; plot(Y); hold off;

toc
