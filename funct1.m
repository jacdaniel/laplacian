function y = funct1(x, data)

width = data.width;
height = data.height;
depth = data.depth;

x1 = reshape(x, [width, height])';

yx1 = opDx_dir(x1, 1);
yy1 = opDy_dir(x1, 1);

y1 = opDx_trans(yx1, 1);
y2 = opDy_trans(yy1,1);

y = y1+y2;
y = y';
y = y(:);
