my (Robin) interpretation of the hyperparameter testing results.

notation: train function, [hidden layers], cost function, datasize, time in min

good
	- trainlm, 400, mse, 40:8500, 22
	- trainlm, [50 25], mse, 40:8500, 14
	- trainlm, [60 30], mse, 40:8500, 5.7
	- trainlm, [100 50], mse, 40:8500, 5.7

decent
	- trainlm, [20 10], mse, 40:8500, <1
	- trainlm, [30 15], mse, 40:8500, 1.42
	- trainlm, [40 20], mse, 40:8500, 5.7
	- trainlm, [70 35], mse, 40:8500, 5.7
	- trainlm, 800, mse, 40:8500, 51
	- trainlm, 160, mse, 40:8500, 8
	- trainlm, 180, mse, 40:8500, 8
	- trainlm, 200, mse, 40:8500, 18
	- trainlm, 300, mse, 40:8500, 12
	- trainlm, 600, mse, 40:8500, 32
	- trainlm, 1000, mse, 40:8500, 12



bad
	- trainlm, 10, mse, 40:8500, <1
	- trainlm, 20, mse, 40:8500, <1
	- trainlm, [10 5], mse, 40:8500, <1
	- trainlm, 30, mse, 40:8500, <1
	- trainlm, 40, mse, 40:8500, <1
	- trainlm, 50, mse, 40:8500, <1
	- trainlm, 60, mse, 40:8500, <1
	- trainlm, 70, mse, 40:8500, 1.2
	- trainlm, 80, mse, 40:8500, 1.5
	- trainlm, 90, mse, 40:8500, 1.2
	- trainlm, 100, mse, 40:8500, 8.1
	- trainlm, 120, mse, 40:8500, 2.5
	- trainlm, 140, mse, 40:8500, 5.7





