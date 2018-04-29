clear
close all
clc

addpath('tools')

width = 2000;
height = 1500;

[X, Y] = meshgrid(linspace(0,1,width), linspace(0,1,height));

fx = 5;
fy = 3;
rx = sin(2*pi*fx*X+2*pi*fy*Y);
ry = sin(2*pi*fx*X+2*pi*fy*Y);


rhs = (opDx_trans(rx, 1) + opDy_trans(ry,1) );
rhs_v = (rhs)'; rhs_v = rhs_v(:);





nbiter = 1000;
tol = 1e-9;

data.width = width;
data.height = height;
data.depth = 1;

tic
[x0_v, flag0, relres0, maxiter0, resvec0] = pcg(@funct1, rhs_v, tol, nbiter, [], [], [], data);
t0 = toc;

tic
A = operator1_create(width, height);
AA = A'*A;
tt1 = toc;
tic
[x1_v, flag1, relres1, maxiter1, resvec1] = pcg(AA, rhs_v, tol, nbiter);
t1 = toc;


x0 = reshape(x0_v, [width, height])';
x1 = reshape(x1_v, [width, height])';


% Ax 
yx1 = opDx_dir(x0, 1);
yy1 = opDy_dir(x0, 1);
y1 = opDx_trans(yx1, 1);
y2 = opDy_trans(yy1,1);
Ax0 = y1+y2;

yx1 = opDx_dir(x1, 1);
yy1 = opDy_dir(x1, 1);
y1 = opDx_trans(yx1, 1);
y2 = opDy_trans(yy1,1);
Ax1 = y1+y2;



d0 = Ax0 - rhs;
d1 = Ax1 - rhs;
err0 = sqrt(mean(d0(:).^2));
err1 = sqrt(mean(d1(:).^2));
fprintf('t0: %f\nt1: %f [ %f ]\n', t0, t1, t1+tt1)
fprintf('Ax0-b: %f, maxiter: %d\n', err0, maxiter0)
fprintf('Ax1-b: %f, maxiter: %d\n', err1, maxiter1)


