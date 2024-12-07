clc;
clear all;
close all;

% Read and verify the image
imageFile = 'street.jpg';
assert(isfile(imageFile), 'Image file "street.jpg" not found.');
I = imread(imageFile);
figure, imshow(I);
title('Original Image');

% Rotate the image
rotI = imrotate(I, 33, 'crop');
figure, imshow(rotI);
title('Rotated Image');

% Convert to grayscale and apply Canny edge detection
if size(rotI, 3) == 3 % Check if the image is RGB
    grayImage = rgb2gray(rotI);
else
    grayImage = rotI; % If already grayscale
end
figure, imshow(grayImage);
title('Grayscale Image');

BW = edge(grayImage, 'canny');
if nnz(BW) == 0
    error('Edge detection failed. Binary image is empty.');
end
figure, imshow(BW);
title('Binary Image (Canny Edge Detection)');

% Perform Hough Transform
[H, T, R] = hough(BW);
figure, imshow(H, [], 'XData', T, 'YData', R, ...
    'InitialMagnification', 'fit');
title('Hough Transform');
xlabel('\theta (degrees)');
ylabel('\rho (pixels)');
axis on;
axis normal;
hold on;

% Detect peaks in the Hough Transform
p = houghpeaks(H, 5, 'threshold', ceil(0.3 * max(H(:))));
if isempty(p)
    error('No peaks detected in the Hough Transform.');
end
x = T(p(:, 2)); % Theta values
y = R(p(:, 1)); % Rho values
plot(x, y, 's', 'Color', 'white');

% Find and plot Hough lines
lines = houghlines(BW, T, R, p, 'FillGap', 5, 'MinLength', 7);
if isempty(lines)
    error('No lines detected.');
end
figure, imshow(rotI);
title('Detected Lines');
hold on;

for k = 1:length(lines)
    % Get the endpoints of each line
    xy = [lines(k).point1; lines(k).point2];
    
    % Plot the line
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green');
    
    % Plot the endpoints
    plot(xy(1, 1), xy(1, 2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2, 1), xy(2, 2), 'x', 'LineWidth', 2, 'Color', 'red');
end

% Display total number of lines detected
disp(['Total lines detected: ', num2str(length(lines))]);
