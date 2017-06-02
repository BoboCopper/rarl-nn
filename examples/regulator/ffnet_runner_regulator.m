% Regulator

% adding ffnet.m and trainindata.m to the path
addpath('../../scripts');

% adding csv wemding data
addpath('../../data/regulator');

% -----------------------------------------------
% Highlevel configuration of the network
%
hiddenLayers = [5 5 5];
costFunction = 'mse';  % >> help nnperformance
% -----------------------------------------------

% -----------------------------------------------
% Highlevel configuration of the training
%
generation = 100;              % run training #generation * #epoch times
epochs     = 500;             % 

% -----------------------------------------------
% Inputs

csv_data_cm = csvread('data_wemding_cm.csv', 2, 0);
% csv_data_rg = csvread('data_wemding_regulator.csv', 2, 0);

X_CM = csv_data_cm(:, 2:4);

X = transpose(X_CM);

% -----------------------------------------------

% -----------------------------------------------
% Outputs
Y_CM = csv_data_cm(:, 5);
Y = transpose(Y_CM);
% -----------------------------------------------

% -----------------------------------------------
% Plotting (currently for 1D Input / 1D Output)

figure(1);

% xlim([ min(X) max(X) ]); % x limits
ylim([ min(Y) max(Y) ]); % y limits
% -----------------------------------------------

% -----------------------------------------------
% Other configuration
%
rng(0);                             % deterministic setting
showGUI          = true;
createNNFunction = false;        
exportName       = 'examplenet';    % name of the exported nn function
% -----------------------------------------------


% Main loop
% -----------------------------------------------

% init network
net  = ffnet(hiddenLayers, costFunction, epochs, showGUI);

fprintf('------- Starting training... --------\n');

for gen = 1:generation
    [net, tr] = train(net, X, Y); 
%    [net, tr] = train(net, X, Y, 'UseParallel', 'yes');  % GPU Acceleartion
    [trainingError, testError, validationError] = trainingdata(net, X, Y, tr);

    % Console output
    fprintf('\nGeneration %i:\n', gen);
    fprintf('    TrainingError:   %d\n',   trainingError);
    fprintf('    TestError:       %d\n',       testError);
    fprintf('    ValidationError: %d\n', validationError);
end

fprintf('------- Done! --------\n');

% Sample from net
% (not a nice solution, because we write the net to the disk and delete it
% afterwards...sampling from a 'net' is apparantly not easy)

genFunction(net, 'temp_net');
Y_nn = temp_net(X);
plot(Y);
hold on;
plot(Y_nn);
hold off;
delete('temp_net.m');

% -----------------------------------------------
if (createNNFunction)
    genFunction(net, exportName);
end



