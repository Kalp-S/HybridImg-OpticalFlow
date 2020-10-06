function [horizontal vertical boolean] = myFlow(img1, img2, window_length, r)
% Gaussian Filter
gauss = [-1,8,0,-8,1]/12;
%Determine spatial derivatives
I_x = imfilter(img1, gauss);
I_y = imfilter(img1, gauss');
%Generate gaussian filter
gauss = fspecial('gaussian',3,1);
%Determine the difference between img2 and img1 determine the temporal derivitive
I_t = imfilter(img2, gauss) - imfilter(img1, gauss);

%apply filter to each deritive
onesFilter = ones(window_length);
I_xx = imfilter(I_x.^2,onesFilter,'conv');
I_yy = imfilter(I_y.^2,onesFilter,'conv');
I_xy = imfilter(I_x.*I_y,onesFilter,'conv');
I_xt = imfilter(I_x.*I_t,onesFilter,'conv');
I_yt = imfilter(I_y.*I_t,onesFilter,'conv');

% initialize variables
sizeImg1 = size(img1);
horizontal = zeros(sizeImg1);
vertical = zeros(sizeImg1);
boolean = zeros(sizeImg1);
K = floor(window_length/2);

%Find least square fitting solution and determine validity
for i = 1:size(img1,1)
    for j = 1:size(img1,2)
        ATranspA = [I_xx(i,j) I_xy(i,j);I_xy(i,j) I_yy(i,j)];
        ATransB = [I_xt(i,j); I_yt(i,j)];
        t = min(eig(ATranspA));
        %Optical flow is only valid when r is below the set threshold and
        %we assume ATranspA is invertible to determine the solution
        if t>=r
            %If r is below threshold, determine solution and list this position valid
            ofv = pinv(ATranspA)*-ATransB;
            valid = 1;
        else
            %If r is above the threshold, put placeholder solution and list the
            %position as invalid
            ofv = [0 0];
            valid = false;
        end 
        %Store values
        horizontal(i,j) = ofv(1);
        vertical(i,j) = ofv(2);
        boolean(i,j) = valid;
    end
end