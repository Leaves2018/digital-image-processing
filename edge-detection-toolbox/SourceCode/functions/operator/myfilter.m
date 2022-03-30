function res=myfilter(I,H)
% function res=myfilter(I,H)
% -- res    the result of the filter process
% -- I      the input image
% -- H      the input template matrix(should be 2 dimensions)
% e.g.:
%   filename='锐化及边缘检测用途.jpg';
%   I=imread(filename);
%   H=[1,1,1;1,-8,1;1,1,1];
%   res=myfilter(I,H);
%   imshow(res);
%   mkdir('results/myfilter');
%   imwrite(res,['./results/myfilter/',filename]);
I=im2uint8(I);
H=int16(H);
[rows,cols,channels]=size(I);
res=uint8(zeros(rows,cols,channels));

%% calculate 
% [height,width]=size(H);
% hh=(height+1)/2;
% hw=(width+1)/2;
% for k=1:channels
%     chan=int16(zeros(rows+hh,cols+hw));
%     chan(hh:rows+hh-1,hw:cols+hw-1)=I(:,:,k);
%     for i=1:rows
%         for j=1:cols
%             temp=chan(i:i+hh,j:j+hw);
%             res(i,j,k)=sum(sum(H.*temp));
%         end
%     end
% end

%% to accelerate, using 'conv2' instead of 'for' 
for k = 1:channels
    res(:, :, k) = conv2(I(:, :, k), H, 'same');
end
    