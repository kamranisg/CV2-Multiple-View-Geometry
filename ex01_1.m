%% 
% Basic Image Processing
% 
% a) Load the image into workspace.

I=imread('lena.png');
imshow(I);
%% 
% b) Determine the size of Image.

[Rows,Columns,Channels] = size(I);
fprintf('Rows = %d\nColumns = %d\nChannels = %d\n',Rows,Columns,Channels);
%% 
% c) Convert into Grayscale and find Max and Min value of Image.

GreyImage=rgb2gray(I);
imshow(GreyImage)
MAX=max(GreyImage(:))
MIN=min(GreyImage(:))
%% 
% d) Apply Gaussian smoothing filter.

B=imgaussfilt(GreyImage,5);
imshow(B);
%% 
% e) Display all the images 

montage({I,GreyImage,B})
%% 
%