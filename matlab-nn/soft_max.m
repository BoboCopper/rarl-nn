function z = soft_max(z)
    display(z);
    s = sum(exp(z));
    z = exp(z)/s;
    display(z);
end