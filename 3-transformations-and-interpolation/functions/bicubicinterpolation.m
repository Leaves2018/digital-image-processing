function PIXELVALUE=bicubicinterpolation(IMAGE,X,Y,K)
%BICUBICINTERPOLATION Implement the bicubic interpolation.
%   PIXELVALUE = bicubicinterpolation(IMAGE, X, Y, K) calculates the
%   interpolation value of point(X, Y) from IMAGE on the K channel, using 
%   the bicubicinterpolation interpolation.
%
%   Note
%   ----
%   Refer to function MYRESIZE or function MYROTATE to learn how to use
%   this function.
i=floor(X);
j=floor(Y);
u=X-i;
v=Y-j;
A=[S(1+v),S(v),S(1-v),S(2-v)];
B=double([
    IMAGE(j-1,i-1,K),IMAGE(j-1,i,K),IMAGE(j-1,i+1,K),IMAGE(j-1,i+2,K);
    IMAGE(j,i-1,K),IMAGE(j,i,K),IMAGE(j,i+1,K),IMAGE(j,i+2,K);
    IMAGE(j+1,i-1,K),IMAGE(j+1,i,K),IMAGE(j+1,i+1,K),IMAGE(j+1,i+2,K);
    IMAGE(j+2,i-1,K),IMAGE(j+2,i,K),IMAGE(j+2,i+1,K),IMAGE(j+2,i+2,K);
    ]);
C=[S(1+u),S(u),S(1-u),S(2-u)]';
PIXELVALUE=uint8(A*B*C);

% S(x) for bicubic interpolation
function res=S(x)
x=abs(x);
if 0<=x && x<1
    res=1-2*x^2+x^3;
elseif 1<=x && x<2
    res=4-8*x+5*x^2-x^3;
elseif x>=2
    res=0;
end