function PIXELVALUE=bilinearinterpolation(IMAGE,X,Y,K)
%BILINEARINTERPOLATION Implement the bilinear interpolation.
%   PIXELVALUE = bilinearinterpolation(IMAGE, X, Y, K) calculates the
%   interpolation value of point(X, Y) from IMAGE on the K channel, using 
%   the bilinear interpolation.
%
%   Note
%   ----
%   Refer to function MYRESIZE or function MYROTATE to learn how to use
%   this function.
ii=floor(X);
jj=floor(Y);
f1=((ii+1)-X)*IMAGE(jj,ii,K)+(X-ii)*IMAGE(jj,ii+1,K);
f2=((ii+1)-X)*IMAGE(jj+1,ii,K)+(X-ii)*IMAGE(jj+1,ii+1,K);
f12=((jj+1)-Y)*f1+(Y-jj)*f2;
PIXELVALUE=f12;