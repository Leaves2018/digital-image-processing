function RESULT=myresizezoomdemo(INPUTIMAGE,ZOOMAREA,SCALE)

row1=ZOOMAREA{1}(1);
col1=ZOOMAREA{1}(2);
row2=ZOOMAREA{2}(1);
col2=ZOOMAREA{2}(2);

% show the original image
img=INPUTIMAGE{1};
img=img(row1:row2,col1:col2,:);
subplot(2,2,1);
imshow(img);
title('Original image');

% calculate the new range
row1=round(row1*SCALE(2));
col1=round(col1*SCALE(1));
row2=round(row2*SCALE(2));
col2=round(col2*SCALE(1));

% show the nearest-neighbor interpolation result image
nearest_res=INPUTIMAGE{2};
nearest_res=nearest_res(row1:row2,col1:col2,:);
subplot(2,2,2);
imshow(nearest_res);
title('Nearest-neighbor interpolation');

% show the bilinear-neighbor interpolation result image
bilinear_res=INPUTIMAGE{3};
bilinear_res=bilinear_res(row1:row2,col1:col2,:);
subplot(2,2,3);
imshow(bilinear_res);
title('Bilinear interpolation');

% show the bicubic-neighbor interpolation result image
bicubic_res=INPUTIMAGE{4};
bicubic_res=bicubic_res(row1:row2,col1:col2,:);
subplot(2,2,4);
imshow(bicubic_res);
title('Bicubic interpolation');

RESULT={img,nearest_res,bilinear_res,bicubic_res};