function g = opDy_dir(x, grad_order)

dims = size(x);
if ~strcmp(grad_order, '2')
    if length(dims) == 2
        g = [x(2:end, :)-x(1:end-1, :); zeros([1 dims(2)])];
    else
        g = [x(2:end, :, :)-x(1:end-1, :, :); zeros([1 dims(2) dims(3)])];
    end
else
    if length(dims) == 2
        g = [x(2, :)-x(1, :); 0.5*x(3:end, :)-0.5*x(1:end-2, :); x(end, :)-x(end-1, :)];
    else
        g = [x(2, :, :)-x(1, :, :); 0.5*x(3:end, :, :)-0.5*x(1:end-2, :, :); x(end, :, :)-x(end-1, :, :)];
    end
end
end
