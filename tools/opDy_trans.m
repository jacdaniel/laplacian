function g = opDy_trans(x, grad_order)

dims = size(x);
if ~strcmp(grad_order, '2')
    if length(dims) == 2
        z = zeros([1 dims(2)]);
        s = x(1:end-1, :);
    else
        z = zeros([1 dims(2) dims(3)]);
        s = x(1:end-1, :, :);
    end
    g = [z; s]-[s; z];
else
    if length(dims) == 2
        g = [-x(1, :)-0.5*x(2, :); ...
             x(1, :)-0.5*x(3, :);  ...
             0.5*x(2:end-3, :)-0.5*x(4:end-1, :); ...
             0.5*x(end-2, :)-x(end, :); ...
             0.5*x(end-1, :)+x(end, :)];
    else
        g = [-x(1, :, :)-0.5*x(2, :, :); ...
             x(1, :, :)-0.5*x(3, :, :);  ...
             0.5*x(2:end-3, :, :)-0.5*x(4:end-1, :, :); ...
             0.5*x(end-2, :, :)-x(end, :, :); ...
             0.5*x(end-1, :, :)+x(end, :, :)];
    end
end
end
