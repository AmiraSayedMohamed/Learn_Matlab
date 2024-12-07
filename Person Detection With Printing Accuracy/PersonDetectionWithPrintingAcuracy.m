clc
clear alll
close all
warning off
x = imread('img3.jpg');
imshow(x)
peopleDetector=vision.PeopleDetector;
[bboxes,score] = peopleDetector(x);
if(sum(sum(bboxes))~=0)
    I=insertObjectAnnotation(x, 'rectangle', bboxes, score);
    imshow(I);
    title('Detected People and detection scores');
else
    imshow(x);
    title('No People Detected');
end