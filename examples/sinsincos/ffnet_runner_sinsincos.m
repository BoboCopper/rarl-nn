% Fitting example for a sinus(sinus(cosinus)) function

% adding ffnet.m and trainindata.m to the path
addpath('../../scripts');

% -----------------------------------------------
% Highlevel configuration of the network
%
hiddenLayers = [10 10 10];
costFunction = 'mse';  % >> help nnperformance
% -----------------------------------------------

% -----------------------------------------------
% Highlevel configuration of the training
%
generation = 50;              % run training #generation * #epoch times
epochs     = 500;             % 

% -----------------------------------------------
% Inputs

X = 0:0.01:6*pi;  % start 0, stepsize 0.01, end 6*pi

% -----------------------------------------------

% -----------------------------------------------
% Outputs

Y = sinsincos(X); % our example fitting function (batman-alike)
% -----------------------------------------------

% -----------------------------------------------
% Plotting (currently for 1D Input / 1D Output)

figure(1);

xlim([ min(X) max(X) ]); % x limits
ylim([ min(Y) max(Y) ]); % y limits
% -----------------------------------------------

% -----------------------------------------------
% Other configuration
%
rng(0);                             % deterministic setting
showGUI          = false;
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
plot(X,Y,X,Y_nn);
delete('temp_net.m');

% -----------------------------------------------
if (createNNFunction)
    genFunction(net, exportName);
end



