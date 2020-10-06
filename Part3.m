%% Part 3
clc;
clear;

%Get path and images within synth folder
synthPath = 'Sequences/synth';
synthImageList = dir(sprintf('%s/*.png',synthPath));
%Read images assign them to variables
synth0 = imread(sprintf('%s/%s',synthPath,synthImageList(1).name));
synth1 = imread(sprintf('%s/%s',synthPath,synthImageList(2).name));
%Convert to double
synth0 = double(synth0)/double(max(synth0(:)));
synth1= double(synth1)/double(max(synth1(:)));

%Get path and images within corr folder
corrPath = 'Sequences/corridor';
corrImageList = dir(sprintf('%s/*.png',corrPath));
%Read images assign them to variables
imgbt0 = imread(sprintf('%s/%s',corrPath,corrImageList(1).name));
imgbt1 = imread(sprintf('%s/%s',corrPath,corrImageList(2).name));
%Convert to double
imgbt0 = double(imgbt0)/double(max(imgbt0(:)));
imgbt1= double(imgbt1)/double(max(imgbt1(:)));

%Get path and images within sphere folder
spherePath = 'Sequences/sphere';
sphereImageList = dir(sprintf('%s/*.png',spherePath));
%Read images assign them to variables
sphere0 =  rgb2gray(imread(sprintf('%s/%s',spherePath,sphereImageList(1).name)));
sphere1 =  rgb2gray(imread(sprintf('%s/%s',spherePath,sphereImageList(2).name)));
%Convert to double
sphere0 = double(sphere0)/double(max(sphere0(:)));
sphere1 = double(sphere1)/double(max(sphere1(:)));


%Note: The effectr of windowSize is that the flow increases as the window
%size increases, which means the intensity of the colors also increases.

% Part 3.1-3.3 for Sphere
%Determine horizontal and vertical of estimated optical flow and binary map
%of flow for sphere images
[sphereHorizontal, spherevertical, sphereboolean] = myFlow(sphere0 , sphere1 , 20, 0.1);
%Format horizontal and vertical optical flow into format compatible with
%flowToColor method
fToCSphere(:,:,1) = sphereHorizontal;
fToCSphere(:,:,2) = spherevertical;
%Determine color map
cFSphere = flowToColor(fToCSphere);
%Show color map
figure,imshow(cFSphere);
warpSphere = myWarp(sphere1, sphereHorizontal, spherevertical);
%Shows the absolute difference between our warped image and the original
%sphere0 image. Ideally, the image should be entirely black here
figure,imshow(abs(sphere0-warpSphere),[0,1]);
%Loop comparing the original sphere0 image and warped sphere 1 image. Both images
%are nearly identical, expect for the black bar around warped image due to
%the edge cases
for counter = 1:3
    figure,imshow(warpSphere,[0,1]);
    figure,imshow(sphere0,[0,1]);
    drawnow;
end

% Part 3.1-3.3 for Synth
%%Determine horizontal and vertical of estimated optical flow and binary map
%of flow for synth images
[synthhorizontal, synthvetical, synthboolean] = myFlow(synth0 , synth1 , 5, 0.00001);
%Format horizontal and vertical optical flow into format compatible with
%flowToColor method
fToCSynth(:,:,1) = synthhorizontal;
fToCSynth(:,:,2) = synthvetical;
%Determine color map
cFSynth = flowToColor(fToCSynth);
%Shows color map
figure,imshow(cFSynth);
warpSynth = myWarp(synth1, synthhorizontal, synthvetical);
figure,imshow(abs(synth0-warpSynth),[0,1]);
%Loop comparing the original synth0 image and warped synth1 image. Both images
%are nearly identical, expect for the black bar around warped image due to
%the edge cases
for counter = 1:3
    figure;
    imshow(warpSynth,[0,1]);
    figure;
    imshow(synth0);
    drawnow;
end

% Part 3.1-3.3 for corridor
%Determine horizontal and vertical of estimated optical flow and binary map
%of flow for sphere images
[corrhorizontal, corrvertical, corrboolean] = myFlow(imgbt0 , imgbt1 , 20, 0.1);
%Format horizontal and vertical optical flow into format compatible with
%flowToColor method
fToCCorr(:,:,1) = corrhorizontal;
fToCCorr(:,:,2) = corrvertical;
%Determine color
cFCorr = flowToColor(fToCCorr);
%Show color map
figure,imshow(cFCorr);
warpCorr = myWarp(imgbt1, corrhorizontal, corrvertical);
figure,imshow(abs(imgbt0-warpCorr),[0,1]);
%Loop comparing the original corridor image and warped corridor1 image. Both images
%are nearly identical, expect for the black bar around warped image due to
%the edge cases
for counter = 1:3
    figure,imshow(warpCorr,[0,1]);
    figure,imshow(imgbt0,[0,1]);
    drawnow;
end