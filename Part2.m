%% Part 2
clc;
clear;
%Get the images of donald trump and kim jong-un
img1 = double(rgb2gray(imread('image1.jpg')));
img2 = double(rgb2gray(imread('image2.jpg')));
figure,imshow(img1,[]);
figure,imshow(img2,[]);
%Determine sizes of the image
[im1length, im1width] = size(img1);
[im2length, im2width] = size(img2);

%Apply a lowpass filter to the first image
sigma = 5;
gaussian = fspecial('gaussian',2*sigma*3+1,sigma);
gaussian = padarray(gaussian,[im1length, im1width]-(2*sigma*3+1),'post');
gaussian = circshift(gaussian, -3*[sigma sigma]);

im1_dft = fft2(img1, size(img1,1),size(img1,2));
f_dft   = fft2(gaussian, size(img1,1),size(img1,2));
%Multiply with low pass filter get low frequency components
im1_f_dft = im1_dft .* f_dft;
im1_f = ifft2(im1_f_dft);

%Apply a high pass filter to the second image
sigma =10;
gaussian2 = fspecial('gaussian',2*sigma*3+1,sigma);
gaussian2 = padarray(gaussian2,[im2length, im2width]-(2*sigma*3+1),'post');
gaussian2 = circshift(gaussian2, -3*[sigma sigma]);
im2_dft = fft2(img2, size(img2,1),size(img2,2));
f_dft2 = fft2(gaussian2, size(img2,1),size(img2,2));
%Multiply with high pass filter get high frequency components
im2_f_dft = im2_dft .* f_dft2;

%Add the sharp edges of high pass filtered image with low pass filetered
%image to make the blended image
combinedImage = ifft2(im2_dft - im2_f_dft  + im1_f_dft); 
figure(3) ,imshow(combinedImage,[]);