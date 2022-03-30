%% temporarily add custom functions needed to MATLAB search path
addpath('../experiment1/functions');
addpath('../experiment2/functions');

%% FILE -> RGB -> GRAY -> EDGE
RGB = imread('hf.jpg');

% using custom functions
% HSI = rgb2hsi(RGB);
% GRAY = HSI(:, :, 3);
% BW = myedge(GRAY, 'prewitt', 50);
% or using MATLAB built-in functions
GRAY = rgb2gray(RGB);
BW = edge(GRAY, 'prewitt');

% show RGB
subplot(2, 3, 1);
imshow(RGB);
title('Original image');
axis on;
% show GRAY
subplot(2, 3, 2);
imshow(GRAY);
title('Grayscale image (or intensity image)');
axis on;
% show EDGE
subplot(2, 3, 3);
imshow(BW);
title('Edges in intensity image (using prewitt operators with a threshold of 50)');
axis on;

%% Hough transform
[H, T, R] = myhough(BW, 0.5, 0.5);
% [H, T, R] = hough(BW, 'rhoResolution', 0.5, 'thetaResolution', 0.5);
% all(all(H==h));
subplot(2, 3, 4);
imshow(H, [], 'XData', T, 'YData', R, 'InitialMagnification', 'fit');
title('Hough transform');
xlabel('\theta'),ylabel('\rho');
axis on , axis normal, hold on;
colormap(gca, hot);

%% Hough peaks and Hough lines
% Hough peaks
P = houghpeaks(H, 20, 'threshold', ceil(0.3*max(H(:))));
x = T(P(:, 2));
y = R(P(:, 1));
% plot(x, y, 's', 'color', 'white');
plot(x, y, 'ws');
% Hough lines
lines = houghlines(BW, T, R, P, 'FillGap', 5, 'MinLength', 7);

% show Hough lines on the intensity image
subplot(2, 3, 5);
imshow(GRAY);
title('Straight line detection using Hough transform');
axis on;
hold on;
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1;lines(k).point2];
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green');
    plot(xy(1, 1), xy(1, 2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2, 1), xy(2, 2), 'x', 'LineWidth', 2, 'Color', 'red');
    len = norm(lines(k).point1 - lines(k).point2);
    if(len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
plot(xy_long(:, 1), xy_long(:,2), 'LineWidth', 2, 'Color', 'cyan');

% show Hough lines on the original image
subplot(2, 3, 6);
imshow(RGB);
title('Straight line detection using Hough transform');
axis on;
hold on;
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1;lines(k).point2];
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green');
    plot(xy(1, 1), xy(1, 2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2, 1), xy(2, 2), 'x', 'LineWidth', 2, 'Color', 'red');
    len = norm(lines(k).point1 - lines(k).point2);
    if(len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
plot(xy_long(:, 1), xy_long(:,2), 'LineWidth', 2, 'Color', 'cyan');