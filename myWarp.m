function warpedImage = myWarp(img2, horizontal, vertical)
%Determine size of image
[length,width] = size(img2);
%Computer meshgrid using image dimensions
[x,y] = meshgrid(1:length,1:width); 
%Use interpolation to warp the image, subtracting the horizontal and
%vertical optical flows from image 2 to get the original image
warpedImage = interp2(img2,x-horizontal,y-vertical,'linear');
%Check for edge cases, where the value becomes Nan, and make those 0
for i=1:size(warpedImage,1)
    for j=1:size(warpedImage,2)
        if (isnan(warpedImage(i,j)))
            warpedImage(i,j) = 0;
        end
    end
end
