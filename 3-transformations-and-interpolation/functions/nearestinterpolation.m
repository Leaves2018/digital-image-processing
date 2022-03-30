function PIXELVALUE=nearestinterpolation(IMAGE,X,Y,K)
%NEARESTINTERPOLATION Implement the nearest-neighbor interpolation.
%   PIXELVALUE=nearestinterpolation(IMAGE,X,Y,K) calculates the
%   interpolation value of point(X, Y) from IMAGE on the K channel, using 
%   the nearest-neighbor interpolation.
%
%   Note
%   ----
%   Refer to function MYRESIZE or function MYROTATE to learn how to use
%   this function.
PIXELVALUE=IMAGE(round(Y),round(X),K);