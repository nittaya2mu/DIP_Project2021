function TestOtsu

close all, clear all;
img1=imread('./image_dataset/Anthracnose/2.jpg');
img1 = rgb2gray(img1);
% img2=imread('test2.bmp');
% img3=imread('test3.bmp');
%img1=imread('lena_256x256_grey8bit.gif');
%img2=imread('toshi.bmp'); img2=rgb2gray(img2);

th1 = graythresh(img1)*255
% th2=graythresh(img2)*255
% th3=graythresh(img3)*255

figure(2)
subplot(1,2,1),imshow(img1),title('Original image')
subplot(1,2,2),imshow(img1>th1|img1<45),title('After thresholding')
% subplot(3,2,3),imshow(img2),title('Original image')
% subplot(3,2,4),imshow(img2>th2),title('After thresholding')
% subplot(3,2,5),imshow(img3),title('Original image')
% subplot(3,2,6),imshow(img3>th2),title('After thresholding')

figure(4)
[co1,x1]=imhist(img1); pk1=max(co1);
% [co2,x2]=imhist(img2); pk2=max(co2);
% [co3,x3]=imhist(img3); pk3=max(co3);

bar(x1,co1),line([th1 th1],[0 pk1],'Color','r')
title('Ring')
% subplot(3,1,2),bar(x2,co2),line([th2 th2],[0 pk2],'Color','r')
% title('Rectangle')
% subplot(3,1,3),bar(x3,co3),line([th3 th3],[0 pk3],'Color','r')
% title('No smoking')

return
