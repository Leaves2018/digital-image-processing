function sobel=sobelfilter2(image)
% function sobel=sobelfilter2(image)
% -- sobel          the result of the sobel operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=sobelfilter2(img);
%   imshow(res);
%   mkdir('results/sobelfilter');
%   imwrite(res,['./results/sobelfilter/',filename]);
sobeloperator1=[-1,0,1;-2,0,2;-1,0,1];
sobeloperator2=[-1,-2,-1;0,0,0;1,2,1];
sobel=myfilter(image,sobeloperator1)+myfilter(image,sobeloperator2);

