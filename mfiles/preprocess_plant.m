close all, clear all;

% import image
img=imread('./image_dataset/Anthracnose/2.jpg');
img=rgb2gray(img);
[vsize,hsize]=size(img);

% Low contrast of image.
img2=imadjust(img,[0.3 0.7],[0.3 0.7]);
imshow(img2);

%=================================================================
%   Gray level transformations
%=================================================================
%buf1=imadjust(img2,[0 1],[1 0]);      %Negative transformation.
%buf2=imadjust(img2,[0 1],[0 1],0.4); %Gray-level transformation.
%buf3=imadjust(img2,[0 1],[0 1],0.67); %Gray-level transformation.
buf4=imadjust(img2,[0 1],[0 1],1.5); %Gray-level transformation.
%buf5=imadjust(img,[0 1],[0 1],2.5); %Gray-level transformation.
%=================================================================

%=================================================================
%   Histogram equalization
%=================================================================
buf6=histeq(img2);%Histogram equalization.

buf7(1:vsize/2,1:hsize/2)=histeq(img2(1:vsize/2,1:hsize/2));
buf7(vsize/2+1:vsize,1:hsize/2)=histeq(img2(vsize/2+1:vsize,1:hsize/2));
buf7(1:vsize/2,hsize/2+1:hsize)=histeq(img2(1:vsize/2,hsize/2+1:hsize));    
buf7(vsize/2+1:vsize,hsize/2+1:hsize)=histeq(img2(vsize/2+1:vsize,hsize/2+1:hsize));    
%=================================================================

%=================================================================
%   Results display
%=================================================================
%Negative transform
figure(10)
subplot(2,2,1),imshow(img2),title('(a) Original Image')
subplot(2,2,2),imshow(buf4),title('(b) Gray-level transformation function Gamma=1.5')
subplot(2,2,3),imhist(img2),title('(c) Original Hisgoram')
subplot(2,2,4),imhist(buf4),title('(d) Gray-level transformation Histogram')

% figure(20)
% subplot(2,2,1),imshow(buf2),title('(a) \gamma= 0.4')
% subplot(2,2,2),imshow(buf3),title('(b) \gamma= 0.67')
% subplot(2,2,3),imhist(buf2),title('(c) \gamma= 0.4')
% subplot(2,2,4),imhist(buf3),title('(d) \gamma=0.67')

% figure(30)
% subplot(2,2,1),imshow(buf4),title('(a) \gamma= 1.5')
% %subplot(2,2,2),imshow(buf5),title('(b) \gamma= 2.5')
% subplot(2,2,3),imhist(buf4),title('(c) \gamma= 1.5')
% %subplot(2,2,4),imhist(buf5),title('(d) \gamma= 2.5')

figure(40)
subplot(2,2,1),imshow(img2),title('(a) Original Image')
subplot(2,2,2),imshow(buf6),title('(b) Histogram Equalization')
subplot(2,2,3),imhist(img2),title('(c) Original Hisgoram')
subplot(2,2,4),imhist(buf6),title('(d) Histogram Equalized')

% figure(50)
% %subplot(2,2,1),imshow(img),title('(a) Original Image')
% subplot(2,2,1),imshow(img2),title('(a) Original Image')
% subplot(2,2,2),imshow(buf7),title('(b) Local Histogram Equalization')
% subplot(2,2,3),imhist(buf1),title('(c) Original Histogram')
% subplot(2,2,4),imhist(buf7),title('(d) Local Histogram Equalized')

%=================================================================
