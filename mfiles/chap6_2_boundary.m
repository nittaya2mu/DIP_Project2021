function chap6_2_boundary
%% This function is for applying the image erosion for boundary extraction
% Boundary = original image - its erosion

close all, clear all;
% read image
img = imread('licoln_from_penny.tif');
SE = strel('square',3);

im_erode = imerode(img,SE);

boundary = img-im_erode;

figure,
subplot(1,2,1), imshow(img), xlabel('Original Image');
subplot(1,2,2), imshow(boundary), xlabel('Image Boundary');

figure,
imshow(img);
hold on;  % overlay plotting
[bx, by] = find(boundary==1); % find boundary pixel
plot(by,bx,'r.');
hold off;

end