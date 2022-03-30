function res = meanfilter(mat, width, height)
% res = medianfilter(img, width, height)
% -- res        the result of the median filter process
% -- img        the input image matrix(should be 2 dimensions)
% -- width      the width of template
% -- height     the height of template
% e.g.:
%   filename='noise.jpg';
%   img=imread(filename);
%   width=3;height=3;
%   res = meanfilter(img, width, height);
%   imshow(res);
%   mkdir('results/meanfilter');
%   imwrite(res,['./results/meanfilter/',filename]);

res=im2uint8(zeros(size(mat)));
[rows,cols]=size(mat);

for i = 1:(rows-height + 1)
    for j = 1:(cols-width + 1)
        temp = mat(i:i+height-1, j:j+width-1);
        res((i+i+height-1)/2, (j+j+width-1)/2) = round(mean(temp(:)));
    end
end