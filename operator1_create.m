function A = operator1_create(width, height)

Dx = sparse(width, width);
i = 1:width-1;
for i = 1:width-1
    Dx(i,i) = -1;
    Dx(i, i+1) = 1;
end

Ip1 = sparse(width, width);
Im1 = sparse(width, width);
for i = 1:width
    Ip1(i,i) = 1;
    Im1(i, i) = -1;
end

N = width*height;
Lx = sparse(N, N);
Ly = sparse(N, N);

for i=0:height-1
    Lx(i*width+1:(i+1)*width,i*width+1:(i+1)*width) = Dx;
end

for i=0:height-2
   Ly(i*width+1:(i+1)*width, i*width+1:(i+1)*width) = Im1;
   Ly(i*width+1:(i+1)*width, (i*width+1:(i+1)*width)+width) = Ip1;    
end

A = [ Lx ; Ly];
