## Regulator system observations:


* Data preprocessing is important `movmean(Y,50)`, this allows for a simpler model (if we have enough data - e.g 8k datapoints)
* `trainlm` with a low variance input can learn a smooth curve e.g `sin(sin(cos([0:0.01:2*pi])))`
* `mse` as cost function is faster than `sse` and does not have a big influence on the regularization
* `trainscg` is very fast and GPU parallelizable, generates more fluctuating models
* a better / faster model is (with our data) one, that has more layers with less neurons
    * [200 100 50] is comparable to
    * [50 35 15 10 5]
* decreasing layer size looks better than `inc -> dec -> inc`
* 50 is a magic number -> [50 50 50 50 50] gives the validation error ~ 8 on `mse`
* steps starting from 200 and decreasing by 25 look like the best model up to date (8 layers starting with 200 got us an error of 3.9)