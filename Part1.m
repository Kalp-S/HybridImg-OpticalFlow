%Lab Written by Kalp Shah 500701904
%% Part 1.1
clc;
clear;
%Make an array of gaussian kernals to iterate through
kernals = [5 7 13 21 31 41 51 71];
%Number of gaussian array sizes
kSizeLen = size(kernals); 
%Import random image I found on the internet
image = imread('unnamed.jpg');
%Convert to grayscale, in case we need to perform operations on it
imgray = rgb2gray(image);
sigma = 2;
%Iterate through the various gaussian kernal sizes to perform convolutions
%using conv2
for i = 1:kSizeLen(2)
    tic
    gaussianFilter = fspecial('gaussian', [kernals(i) kernals(i)],sigma);
    %Convolution using conv2
    convolved = conv2(double(gaussianFilter), double(imgray));
    execution(i) = toc;
end
%plot result of processing times using conv2
figure,plot(kernals, execution); 
hold on

%% Part 1.2
clc;
clear;

kernals = [5 7 13 21 31 41 51 71];
kSizeLen = size(kernals); 
image = imread('unnamed.jpg');
imgray = double(rgb2gray(image))/255;
sigma = 2;
%Iterate through the gaussian kernal sizes to perform convolution using
%multiplication in freq. domain and inverse DFT
for i =  1:kSizeLen(2)
    tic
    fourier = fspecial('gaussian', [kernals(i) kernals(i)], sigma)
    image_dft = fft2(imgray, size(imgray,1), size(imgray,2));
    %DFT
    fourier_dft = fft2(fourier, size(imgray,1), size(imgray,2));
    %Multiplying in frequency domain
    image_fourier_dft = image_dft.* fourier_dft;
    %Inverse DFT
    inverseDFT = ifft2(image_fourier_dft);
    execution(i) = toc;
end
plot(kernals, execution);

%% Part 1.3

%The plots which are generated show the execution time to perform the same
%operations between the conv2 and DFT and inverse DFT method. We see from
%the execution times, conv2 shows a higher rate of growth than the DFT and
%inverse DFT method.