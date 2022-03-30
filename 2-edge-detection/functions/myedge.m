function res=myedge(img,operator,threshold)
% function res=myedge(img,operator,threshold)
% -- res        the edge result of the input image
% -- image      the input image
% -- operator   the input operator(should be 2 dimensional odd-order matrix)
%               or string like 'laplacian'/'sobel'/'prewitt'/'roberts'
% -- threshold  threshold to decide whther a pixel on the edge should be black or white 
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   operator='laplacian';
%   threshold=233;
%   res=myedge(img,operator,threshold);
%   imshow(res);
%   mkdir(['results/myedge/',operator]);
%   imwrite(res,['./results/myedge/',operator,'/',filename]);
if ischar(operator)
    switch operator
        case 'laplacian'
            res=laplacianfilter2(img);
        case 'sobel'
            res=sobelfilter2(img);
        case 'prewitt'
            res=prewittfilter2(img);
        case 'roberts'
            res=robertsfilter2(img);
    end
else
    res=myfilter(img,operator);
end
res(res<threshold)=0;
res(res>=threshold)=255;