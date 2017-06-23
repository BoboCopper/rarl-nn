function validationError = ffnet_runner_regulator(trainFcn, hiddenLayers, costFunction, from, to, stepSize)

% Regulator

% adding ffnet.m and trainindata.m to the path
addpath('../../scripts');

% adding csv wemding data
addpath('../../data/regulator');

% -----------------------------------------------
% Highlevel configuration of the network

% using mean absolute error (L1-loss)

% elapsed time
tic
% -----------------------------------------------
% Parallization

multiCoreActive       = 1;
gpuAccelerationActive = 0;

% -----------------------------------------------

% -----------------------------------------------

% -----------------------------------------------
% Highlevel configuration of the training
%
generation = 1;              % run training #generation * #epoch times
epochs     = 10000;          % 

% -----------------------------------------------
% Inputs

csv_data_cm = csvread('data_wemding_cm_to_cm_preprocessed_1_8741.csv', 0, 0);
% csv_data_rg = csvread('data_wemding_regulator.csv', 2, 0);

X_CM = csv_data_cm(from:stepSize:to, 1:3);
X_CM = transpose(X_CM);

% X_RG = csv_data_rg(from:to, 2:4);
% X_RG = transpose(X_RG);

X = X_CM;
% X = [X_CM, X_RG];

% -----------------------------------------------

% -----------------------------------------------
% Outputs
Y_CM = csv_data_cm(from:stepSize:to, 4);
Y = transpose(Y_CM);
% Y = movmean(Y,70);

% Y = [Y, Y]; % double the Y's because we have the X_CM + X_RG

% -----------------------------------------------

% -----------------------------------------------
% Plotting (currently for 1D Input / 1D Output)

figure(1);
clf;

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
% 
% init network
net = feedforwardnet(hiddenLayers, trainFcn);
% START set weights and biases of net + dropout layer -----------------------------------
for layer = 1:size(hiddenLayers)
    % dropoutLayer syntax: layer = dropoutLayer(probability, opt: name, opt: value_for_name);
    % just a random probability decreasing with increasing iterations
    % probability = (0.5 - layer);
    % net.layer{layer} = dropoutLayer(probability);
    net.layers{layer}.initFcn = 'initwb';
    for weight = 1:size(net.layers{layer})
        net.inputWeights{layer,weight}.initFcn = 'randsmall';

        net.layerWeights{layer,weight}.initFcn = 'randsmall';
    end
    net.biases{layer}.initFcn = 'randsmall';
end
net = init(net);

% END set weigths and biases of net + dropout layer -------------------------------------


% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
% net.input.processFcns = {'removeconstantrows','mapminmax'};
% net.output.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'divideint';  % Divide data based on intervals
net.divideMode = 'sample';  % Divide up every sample

% we only use this for RL training, we don't have a testRatio/valRatio
net.divideParam.trainRatio = 75/100;
net.divideParam.valRatio = 25/100;
net.divideParam.testRatio = 0/100;

% how often can the validation error rise
net.trainParam.max_fail = 100; 

% only L2 regularisation is possible (1/n * sum(w^2))
net.performParam.regularization = 0.5;

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = costFunction;

% We only have want to learn one-by-one, because we don't have batches in RL
net.trainParam.epochs = epochs;

% Don't open unneeded GUIs
net.trainParam.showWindow = showGUI;


fprintf('------- Starting training... --------\n');

for gen = 1:generation
    
%    if multiCoreActive && multiCoreActive
%        [net, tr] = train(net, X, Y, 'useParallel','yes','useGPU','yes','showResources','yes'); 
        
%    elseif gpuAccelerationActive
%        [net, tr] = train(net, X, Y, 'useGPU','yes','showResources','yes'); 
         
%    elseif multiCoreActive
        [net, tr] = train(net, X, Y, 'useGPU', 'yes', 'showResources','yes'); 
        
%    else
%        [net, tr] = train(net, X, Y);
%    end
    
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

% write data to plot
dim = [.02 0 0 .9];
str = strcat('trainFcn: ', trainFcn);
annotation('textbox',dim,'String',str, 'FitBoxToText','on');

dim = [.02 0 0 .8];
str = strcat('hiddenLayers: ', mat2str(hiddenLayers));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

dim = [.02 0 0 .7];
str = strcat('costFcn: ', costFunction);
annotation('textbox',dim,'String',str,'FitBoxToText','on');

dim = [.02 0 0 .6];
str = strcat(strcat(strcat('dataSize: ', num2str(from)), ':'), num2str(to));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

dim = [.02 0 0 .5];
str = strcat('trainError: ', num2str(trainingError));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

dim = [.02 0 0 .4];
str = strcat('valError: ', num2str(validationError));
annotation('textbox',dim,'String',str,'FitBoxToText','on');

dim = [.02 0 0 .3];
str = strcat('time in min: ', num2str(toc / 60));
annotation('textbox',dim,'String',str,'FitBoxToText','on');


% START save figure file with following syntax:
% validationError-hiddenLayers-costFunction-from-to
s = 'e-';
s = strcat(s, num2str(validationError), '-');

for layerSize = 1:length(hiddenLayers)
   s = strcat(s, num2str(hiddenLayers(layerSize)), '-');
end

s = strcat(s, trainFcn, '-');
s = strcat(s, costFunction);
s = strcat(s, '+', num2str(from), '-', num2str(to));

title(s);
saveas(gcf, strcat(s, '.fig'));

% END save figure file with following syntax: hiddenLayers-costFunction
hold off;
delete('temp_net.m');

% -----------------------------------------------
if (createNNFunction)
    genFunction(net, strcat(s, '.m'));
end

save(strcat(s, '.m'), 'net');

% elapsed time
toc

end



