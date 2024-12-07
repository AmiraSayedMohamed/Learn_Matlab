clear;
clc;

% Read the image
img = imread('img1.jpg');
imshow(img);
title('Original Image');

% Convert to grayscale
gray_img = rgb2gray(img);

% Binarize the image
binary_img = imbinarize(gray_img, 0.5);

% Apply noise reduction
filtered_img = medfilt2(binary_img);
figure, imshow(filtered_img);
title('Processed Binary Image');

% Perform OCR
result = ocr(filtered_img, 'Language', 'eng');

% Display recognized text
disp('Recognized Text:');
disp(result.Text);
