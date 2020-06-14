I=imreadbw('img1.png');
%%
imshow(I)
%%
[score, points] = getHarrisCorners(I, 2, 0.05, 1e-7);
%%
drawPts(I,points)