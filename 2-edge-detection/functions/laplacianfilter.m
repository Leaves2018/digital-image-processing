function laplacian=laplacianfilter(image)
% function laplacian=laplacianfilter(image)
% -- laplacian      the result of the laplacian operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=laplacianfilter(img);
%   imshow(res);
%   mkdir('results/laplacianfilter');
%   imwrite(res,['./results/laplacianfilter/',filename]);

image=im2uint8(image);
[rows,cols,channels]=size(image);
laplacian=uint8(zeros(rows,cols,channels));

for k=1:channels
    chan=int16(zeros(rows+2,cols+2));
    chan(2:rows+1,2:cols+1)=image(:,:,k);
    for i=1:rows
        for j=1:cols
            temp=chan(i:i+2, j:j+2);
            laplacian(i,j,k)=sum(temp(:))-9*chan(i+1,j+1);
        end
    end
end


