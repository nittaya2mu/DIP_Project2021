img=imread('darkPollen.jpg');
output=histeq(img);

figure, 
subplot(2,2,1), imshow(img,[]), title('Original Image');
subplot(2,2,2), imshow(output,[]), title('After Histogram Equalization');
subplot(2,2,3), imhist(img), title('Original Histogram');
subplot(2,2,4), imhist(output), title('Histogram Equalized');

