close all, clear all;
img = imread('moon.bmp');

% Power-law transformation
output = imadjust(img, [0.1 0.9],[0 1],0.3);

figure,
subplot(2,2,1), imshow(img,[]), title('original image');
subplot(2,2,2), imshow(output,[]), title('after power-law transformation');

% Negative transformation
max_level = max(max(img))
min_level = min(min(img))

output = max_level-1-img;
subplot(2,2,3), imshow(output,[]), title('after negative transformation');

% Log transformation
c = 1;
output = c*log(1+double(img));
subplot(2,2,4), imshow(output,[]), title('after Log transformation');
