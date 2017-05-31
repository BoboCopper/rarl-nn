bound = 3*pi;

X = [0.0:0.01:bound];
Y = sin(sin(cos(X) * 2)*2 + 2);

figure(1);
subplot(2,2,1);
plot(X,X);
title X;

subplot(2,2,2);
ylim([-1 1]);
plot(X,Y);
title Y;

subplot(2,2,4);
ylim([-1 1]);

xor_training;


Y_nn = [];
for i = 0.0:0.01:bound
   Y_nn = [Y_nn sinsincosnet(i)];
end

plot(X,Y_nn);
ylim([-1 1]);
title Y^{nn};