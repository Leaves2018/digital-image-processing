function [Iedge, Gstrongedge] = cannyfilter2(I, lowThreshold, highThreshold)
% Here is a simple example for how to use cannyfilter2.
% I = imread('images/cameraman.png'); % demo picture
% [Iedge, Gstrongedge] = cannyfilter2(I, 0.1, 0.2);

%% (if) rgb -> hsi and process
addpath('functions/utils'); % import utils, including rgb2hsi
[rows, cols, dims] = size(I);
if dims > 1
%     I = rgb2gray(src); % it seems result based on gray image cannot be
%     added to the original iamge, but intensity of hsi can.
    Ihsi = rgb2hsi(I);
    I = Ihsi(:, :, 3);
end

%% Set (horizontal and vertical) sobel operator 
sobelH = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
sobelV = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

%% Calculate gradient G and angle theta
preGx = conv2(I, sobelH, 'same');
preGy = conv2(I, sobelV, 'same');

Gx = zeros(size(preGx));
Gy = zeros(size(preGy));
for y = 2:(rows - 1)
    for x = 2:(cols - 1)
        tempGx = preGx(y - 1 : y + 1, x - 1 : x + 1);
        Gx(y, x) = sum(sum(tempGx));
        tempGy = preGy(y - 1 : y + 1, x - 1 : x + 1);
        Gy(y, x) = sum(sum(tempGy));
    end
end
G = sqrt(Gx.^2 + Gy.^2);
theta = atand(Gy./(Gx+eps)); % plus Gx with eps in case of NaN

%% Non-marginal suppression
Gedge = G;
for y = 2:(rows - 1)
    for x = 2:(cols - 1)
        t = theta(y, x);
        if t < -45
            Gp1 = (1 - tand(90 - t))*G(y + 1, x) + tand(90 - t) * G(y + 1, x + 1);
            Gp2 = (1 - tand(90 - t))*G(y - 1, x) + tand(90 - t) * G(y - 1, x - 1);
        elseif t < 0
            Gp1 = (1 - tand(t))*G(y, x + 1) + tand(t) * G(y + 1, x + 1);
            Gp2 = (1 - tand(t))*G(y, x - 1) + tand(t) * G(y - 1, x - 1);
        elseif t< 45
            Gp1 = (1 - tand(t))*G(y, x + 1) + tand(t) * G(y + 1, x + 1);
            Gp2 = (1 - tand(t))*G(y, x - 1) + tand(t) * G(y - 1, x - 1);
        else
            Gp1 = (1 - tand(90 - t))*G(y - 1, x) + tand(90 - t) * G(y - 1, x + 1);
            Gp2 = (1 - tand(90 - t))*G(y + 1, x) + tand(90 - t) * G(y + 1, x - 1);
        end
%         Gp = G(y, x);
%         if Gp >= Gp1 && Gp >= Gp2
%             % Gp may be an edge
%         else 
%             % Gp should be suppressed
%         end
        if G(y, x) < max(Gp1, Gp2)
%             G(y, x) = 0;
            Gedge(y, x) = 0;
        end
    end
end
%% Dual Threshold Detection
Gedgemax = max(max(Gedge));
highThreshold = Gedgemax * highThreshold;
lowThreshold = Gedgemax * lowThreshold;
Gstrongedge = zeros(size(Gedge));
Gweakedge = zeros(size(Gedge));
for y = 2:(rows - 1)
    for x = 2:(cols - 1)
        if Gedge(y, x) >= highThreshold
            Gstrongedge(y, x) = 1;
        elseif Gedge(y, x) >= lowThreshold
            Gweakedge(y, x) = 1;
        end
    end
end
%% Isolation point suppression
for y = 2:(rows - 1)
    for x = 2:(cols - 1)
        if Gweakedge(y, x)
            temp = Gstrongedge(y - 1 : y + 1, x - 1 : x + 1);
            if sum(sum(temp)) > 0
                Gstrongedge(y, x) = 1;
            end
        end
    end
end

%% Output: non-binary edge and binary edge
Iedge = I;
for y = 2:(rows - 1)
    for x = 2:(cols - 1)
        if ~Gstrongedge(y, x)
            Iedge(y, x) = 0;
        end
    end
end
