% Single Thresholding -> 1 threshold value
% if gray level of input > T then output becomes white (1)
%    gray level of input <= T then output becomes black (0)
close all, clear all;

img = imread('./image_dataset/Anthracnose/2.jpg');   % read input image
img = mat2gray(rgb2gray(img));
T = 0.5;
T2 = graythresh(img);

[rows, cols] = size(img);
output = zeros(rows, cols);

pos = (img) > T;
output(pos) = 1;

pos2 = (img) > T2;

figure, 
subplot(1,2,1), imshow(pos, []), title('manual define T');
subplot(1,2,2), imshow(pos2, []), title('Otsu method define T');

% plot boundary
[B,L] = bwboundaries(pos2,'noholes');
figure, imshow(img,[]);
hold on,
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end

% plot boundary
[B,L] = bwboundaries(pos,'noholes');
hold on,
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end