setupWorkspace;

tic

curCell = cell(1);
singleResult = cell(1);
xi = cell(1, 4);
xi{1} = 0;
xi{2} = 0;
xi{3} = 0;
xi{4} = 0;
Y_new = [];
[cols, rows] = size(X_CM);
for i = 1:rows
    curCell{1} = X_CM(1:cols, i);
    % singleResult = customFitnet(curCell);
    singleResult = test(curCell, xi);
    if(i > 1)
        xi{1} = X_CM(1:cols, i-1);
        if(i > 2)
            xi{2} = X_CM(1:cols, i-2);
            if(i > 3)
                xi{2} = X_CM(1:cols, i-3);
                if(i > 4)
                xi{2} = X_CM(1:cols, i-4);
                end
            end
        end
    end
    Y_new = [Y_new singleResult{1}];
end

toc
