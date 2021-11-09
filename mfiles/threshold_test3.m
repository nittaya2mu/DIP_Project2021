% input image
img = imread('rice.tif');
[w,h] = size(img);

% Global thresholding
gt = im2bw(img, graythresh(img));

% Adaptive thresholding (local thresholding)

% create sub-images
im1 = img(:, 1:128);
im2 = img(:, 129:192);
im3 = img(:, 193:256);
im4 = img(:, 257:324);
im5 = img(:, 325:400);
im6 = img(:, 401:484);
im7 = img(:, 485:576);
im8 = img(:, 577:600);

% apply thresholding to sub-images
g1 = im2bw(im1, graythresh(im1));
g2 = im2bw(im2, graythresh(im2));
g3 = im2bw(im3, graythresh(im3));
g4 = im2bw(im4, graythresh(im4));
g5 = im2bw(im5, graythresh(im5));
g6 = im2bw(im6, graythresh(im6));
g7 = im2bw(im7, graythresh(im7));
g8 = im2bw(im8, graythresh(im8));

figure, imshow([g1 g2 g3 g4 g5 g6 g7 g8]);

% plot boundary
[B,L] = bwboundaries(gt,'noholes');
figure, imshow(img,[]);
hold on,
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end

% plot boundary
[B,L] = bwboundaries([g1 g2 g3 g4 g5 g6 g7 g8],'noholes');
hold on,
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end