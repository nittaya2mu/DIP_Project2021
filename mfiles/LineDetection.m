%============================================================
%   Program name: LineDetection.m
%         Author: Toshi
%           Date: Jan. 25, 2005
%         Update: Jan. 28, 2005
%
%   <Note>
%   This program is written for testing a line 
%   detection method.
%============================================================

function LineDetection

close all, clear all

%============================================================
%   Image reading and the set up of convolution images
%============================================================
% img=zeros(128,128);

% img(64,:)=1; img(:,64)=1;

% for j=1:128
%     img(j,j)=1;
%     img(j,129-j)=1;
% end

img=imread('./image_dataset/Anthracnose/2.jpg');
img=rgb2gray(img);
%img=imread('lena_256x256_grey8bit.gif');
%img=imread('mandril.jpg'); img=rgb2gray(img);
%img=imread('toshi.jpg'); img=rgb2gray(img);

imsize=size(img); vsize=imsize(1,1), hsize=imsize(1,2)

figure(1)
subplot(2,3,1),imshow(img),title('Original image')

lap=-fspecial('laplacian');
mask1=[-1 -1 -1; 2 2 2; -1 -1 -1];
mask2=[-1 -1 2; -1 2 -1; 2 -1 -1];
mask3=[-1 2 -1; -1 2 -1; -1 2 -1];
mask4=[2 -1 -1; -1 2 -1; -1 -1 2];
%============================================================


%============================================================
%   Convolution
%============================================================
dimg=double(img);
buf0=(round(conv2(dimg,lap,'same')));
buf1=(round(conv2(dimg,mask1,'same')));
buf2=(round(conv2(dimg,mask2,'same')));
buf3=(round(conv2(dimg,mask3,'same')));
buf4=(round(conv2(dimg,mask4,'same')));
%============================================================


%============================================================
%   Image display
%============================================================
%figure(3),
oup0=uint8(mat2gray(buf0)*255);
oup1=uint8(mat2gray(buf1)*255);
oup2=uint8(mat2gray(buf2)*255);
oup3=uint8(mat2gray(buf3)*255);
oup4=uint8(mat2gray(buf4)*255);
subplot(2,3,2),imshow(oup1),title('Mask 1')
subplot(2,3,3),imshow(oup2),title('Mask 2')
subplot(2,3,4),imshow(oup3),title('Mask 3')
subplot(2,3,5),imshow(oup4),title('Mask 4')
%============================================================


%============================================================
%   Selection of the maximum response
%============================================================
buf5=zeros(vsize,hsize);
for j=1:vsize
    for i=1:hsize
        buf5(j,i)=max([buf1(j,i) buf2(j,i) buf3(j,i) buf4(j,i)]);
    end
end

%figure(11),
oup5=uint8(mat2gray(buf5)*255);
subplot(2,3,6),imshow(oup5),title('Final result')

figure(3)
subplot(1,2,1),imshow(img),title('Original image')
subplot(1,2,2),imshow(oup0),title('Lines by Laplacian')
%============================================================

return