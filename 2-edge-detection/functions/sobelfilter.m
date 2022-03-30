function sobel=sobelfilter(image)
% function sobel=sobelfilter(image)
% -- sobel          the result of the sobel operator filter process
% -- image          the input image
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   img=imread(filename);
%   res=sobelfilter(img);
%   imshow(res);
%   mkdir('results/sobelfilter');
%   imwrite(res,['./results/sobelfilter/',filename]);
sobeloperator1=int16([-1,0,1;-2,0,2;-1,0,1]);
sobeloperator2=int16([-1,-2,-1;0,0,0;1,2,1]);
image=im2uint8(image);
[rows,cols,channels]=size(image);
sobel1=uint8(zeros(rows,cols,channels));
sobel2=uint8(zeros(rows,cols,channels));

for k=1:channels
    chan=int16(zeros(rows+2,cols+2));
    chan(2:rows+1,2:cols+1)=image(:,:,k);
    for i=1:rows
        for j=1:cols
            temp=chan(i:i+2,j:j+2);
            sobel1(i,j,k)=sum(sum(sobeloperator1.*temp));
            sobel2(i,j,k)=sum(sum(sobeloperator2.*temp));
        end
    end
end
sobel=abs(sobel1)+abs(sobel2);

