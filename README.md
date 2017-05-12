# MATLAB Feed Forward Neural Networks with Back Propagation
The implementations provided here do not require any toolboxes, especially **no neural network toolbox**.

The neural network implementations in this repo are set up in three complexities:

  1. `simpleTrainExample`: Script which trains a neural network of 3 layers (in, hidden, out), each consisting of only a single neuron. Not really functional for any task, primarily available for understanding the basic behavior.
  2. `trainNeuralNetStatic`: Function which is capable of training a basic neural network of 3 layers with an arbitrary amount of neurons each. Look at this before looking at the next function! Takes a network generated by the `generateNeuralNet` function and uses `applyNeuralNet`.
  3. `trainNeuralNet` : Function which trains networks of arbitrary size. Basically wraps the backpropagation behavior of `trainNeuralNetStatic` into an extra loop in order to handle more layers.
