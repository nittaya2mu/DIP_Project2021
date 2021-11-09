function sobel_op
% Apply Sobel operator

% 1. obtain input image
%     img = imread('contact_lens_original.tif');
    img = imread('moon.bmp');

% 2. obtain Sobel masks
mask1 = fspecial('Sobel');
mask2 = mask1';     %Transpose

% 3. Apply Sobel operators to input image
gx = filter2(mask1, img, 'same');
gy = filter2(mask2, img, 'same');

% 4. Calculate magnitude
gradientImg = sqrt(gx.^2 + gy.^2);

% 5. Display gradient image
figure, 
subplot(1,2,1), imshow(img);
subplot(1,2,2), imshow(mat2gray(gradientImg));
