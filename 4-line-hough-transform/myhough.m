function [h, theta, rho] = myhough(bw, rhoResolution, thetaResolution)
%MYHOUGH Hough transform.
%   MYHOUGH is a weakened version of MATLAB built-in function hough. It
%   implements the Standard Hough Transform using pure MATLAB code (using
%   .m rather than .mex). For more infomation about hough transform, please
%   enter "help hough" in the MATLAB command line. Besides, mydemo.m is a
%   script demo for myhough (as well as hough).

[M,N] = size(bw);

theta = linspace(-90, 0, ceil(90/thetaResolution) + 1);
theta = [theta -fliplr(theta(2:end - 1))];

D = sqrt((M - 1)^2 + (N - 1)^2);
q = ceil(D/rhoResolution);
nrho = 2*q + 1;
rho = linspace(-q*rhoResolution, q*rhoResolution, nrho);


h = zeros(length(rho), length(theta));

t = theta*pi/180;
cost = cos(t);
sint = sin(t);

for y = 1:M
    for x = 1:N
        if bw(y, x)
            r = (x-1)*cost + (y-1)*sint;
            r = round(r/rhoResolution) + q + 1;
            for k = 1:length(t)
                h(r(k), k) = h(r(k), k) + 1;
            end
        end
    end
end



