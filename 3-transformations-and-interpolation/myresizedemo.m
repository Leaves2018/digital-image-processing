function RESULT=myresizedemo(filename,xscale,yscale)
%   Example:
%   ----
%   This is an demo for comparison of different interpolation results using
%   myresize.
%
%       filename='color.jpg';
%       xscale=1.5; yscale=1.5;
%       [img,nearest_res,bilinear_res,bicubic_res]=myresizedemo(filename,xscale,yscale);
img=imread(filename);
addpath('./functions');

subplot(2,2,1);
imshow(img);
title('Original image');

nearest_res=myresize(img,xscale,yscale,'nearest');
subplot(2,2,2);
imshow(nearest_res);
title('Nearest-neighbor interpolation');

bilinear_res=myresize(img,xscale,yscale,'bilinear');
subplot(2,2,3);
imshow(bilinear_res);
title('Bilinear interpolation');

bicubic_res=myresize(img,xscale,yscale,'bicubic');
subplot(2,2,4);
imshow(bicubic_res);
title('Bicubic interpolation');

RESULT={img,nearest_res,bilinear_res,bicubic_res};