function prewitt=prewittfilter(image)
% function prewitt=prewittfilter(image)
% -- prewitt        the result of the prewitt operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=prewittfilter(img);
%   imshow(res);
%   mkdir('results/prewittfilter');
%   imwrite(res,['./results/prewittfilter/',filename]);
image=im2uint8(image);
[rows,cols,channels]=size(image);
prewitt1=uint8(zeros(rows,cols,channels));
prewitt2=uint8(zeros(rows,cols,channels));
for k=1:channels
    chan=int16(zeros(rows+2,cols+2));
    chan(2:rows+1,2:cols+1)=image(:,:,k);
    for i=1:rows
        for j=1:cols
            temp=chan(i+2,j:j+2)-chan(i,j:j+2);
            prewitt1(i,j,k)=sum(temp(:));
            temp=chan(i:i+2,j+2)-chan(i:i+2,j);
            prewitt2(i,j,k)=sum(temp(:));
        end
    end
end

prewitt=prewitt1+prewitt2;