function laplacian=laplacianfilter2(image)
% function laplacian=laplacianfilter2(image)
% -- laplacian      the result of the laplacian operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=laplacianfilter2(img);
%   imshow(res);
%   mkdir('results/laplacianfilter');
%   imwrite(res,['./results/laplacianfilter/',filename]);
laplacianoperator=[1,1,1;1,-8,1;1,1,1];
laplacian=myfilter(image,laplacianoperator);
