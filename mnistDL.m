clear variables

neuralNet = generateNeuralNet([784 300 10]);

input = loadMNISTImages('train-images.idx3-ubyte');
target = loadMNISTLabels('train-labels.idx1-ubyte');
input = transpose(input);
neuralNet = trainNeuralNet(neuralNet, 20000, input, target);

