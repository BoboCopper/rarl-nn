% example periodic function
%
function res = sinsincos(x)
    res = sin(sin(cos(x) * 2)*2 + 2);
end