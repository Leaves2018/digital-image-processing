function roberts=robertsfilter2(image)
% function roberts=robertsfilter2(image)
% -- roberts        the result of the laplacian operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=robertsfilter(img);
%   imshow(res);
%   mkdir('results/robertsfilter2');
%   imwrite(res,['./results/robertsfilter2/',filename]);
robertsoperator1=[0,0,0;0,-1,0;0,0,1];
robertsoperator2=[0,0,0;0,0,-1;0,1,0];
roberts=myfilter(image,robertsoperator1)+myfilter(image,robertsoperator2);