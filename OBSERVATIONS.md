Observations so far:

- trainlm does not seem to work on our training machine because of some parallelization issues.

- trainscg is way faster than any other function.

- according to https://de.mathworks.com/help/nnet/ug/choose-a-multilayer-neural-network-training-function.html,
  it does not matter what train function to choose in case you are time independent (which we are).
  
- although we cannot explain the intuition behind this, layers containing a descending # of neurons with step size ~10-15% work best

- current setup with best performance: feedforward neural net with architecture [200 175 150 125 100 75 50 25] and trainFcn 'trainscg'.

- also somehow, a total number of 50 neurons per layer outputs a decent result.

- all experiments are executed with #generations = 1; #epochs = 10000;
