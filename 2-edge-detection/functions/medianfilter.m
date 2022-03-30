function res = medianfilter(mat, width, height)
% res = medianfilter(img, width, height)
% -- res        the result of the median filter process
% -- img        the input image matrix(should be 2 dimensions)
% -- width      the width of template
% -- height     the height of template
% e.g.:
%   filename='noise.jpg';
%   img=imread(filename);
%   width=3;height=3;
%   res = medianfilter(img, width, height);
%   imshow(res);
%   mkdir('results/medianfilter');
%   imwrite(res,['./results/medianfilter/',filename]);

res=im2uint8(zeros(size(mat)));
[rows,cols]=size(mat);

for i = 1:(rows-height + 1)
    for j = 1:(cols-width + 1)
        temp = mat(i:i+height-1, j:j+width-1);
        temp = sort(temp(:));
        res((i+i+height-1)/2, (j+j+width-1)/2) = temp((length(temp)+1)/2);
    end
end