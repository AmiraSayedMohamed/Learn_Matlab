clc; clear; close all;

% Read and rotate the image
I = imread('street.jpg');
rotI = imrotate(I, 33, 'crop'); 

% Convert to grayscale and detect edges
grayImage = rgb2gray(rotI);
BW = edge(grayImage, 'canny');

% Perform Hough Transform and detect peaks
[H, T, R] = hough(BW);

% Detect peaks in the Hough Transform
p = houghpeaks(H, 5, 'threshold', ceil(0.3 * max(H(:))));

% Find and plot Hough lines
lines = houghlines(BW, T, R, p, 'FillGap', 5, 'MinLength', 7);

% Display the original rotated image with detected lines
figure;
imshow(rotI, 'InitialMagnification', 'fit');
title('Detected Lines');
hold on;

% Plot the detected lines on the image
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    
    % This starts a loop through all the lines detected by the houghlines function.
    % Each line has two endpoints (point1 and point2).
    % xy = [lines(k).point1; lines(k).point2]; combines the coordinates of the two endpoints into the variable xy.

    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green'); % Plot each line on the image with a green line and a line width of 2.
    plot(xy(1, 1), xy(1, 2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2, 1), xy(2, 2), 'x', 'LineWidth', 2, 'Color', 'red');
end

% Display total lines detected
disp(['Total lines detected: ', num2str(length(lines))]);
