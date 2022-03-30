function prewitt=prewittfilter2(image)
% function prewitt=prewittfilter2(image)
% -- prewitt        the result of the prewitt operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=prewittfilter2(img);
%   imshow(res);
%   mkdir('results/prewittfilter');
%   imwrite(res,['./results/prewittfilter/',filename]);
prewittoperator1=[-1,-1,-1;0,0,0;1,1,1];
prewittoperator2=[-1,0,1;-1,0,1;-1,0,1];
prewitt=myfilter(image,prewittoperator1)+myfilter(image,prewittoperator2);