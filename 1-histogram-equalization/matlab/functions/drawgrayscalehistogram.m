function frequency=drawgrayscalehistogram(img,filename)
% e.g.
%   img=imread('color.jpg');
%   filename='color';
%   frequency=drawgrayscalehistogram(img,filename);
img=im2uint8(img);
rows=length(img(:,1));
cols=length(img(1,:))/length(img(1,1,:));
frequency=zeros(1,256);
for i=1:rows
    for j=1:cols
        % Matlab number starts from 1
        temp_grayscale=abs(img(i,j,3))+1;
        frequency(temp_grayscale)=frequency(temp_grayscale)+1;
    end
end
ind=0:255; 
h=figure;
bar(ind,frequency);
title([filename,' grayscale histogram']);
xlabel('grayscale');
ylabel('frequency');
saveas(h, [filename,'_grayscale_histogram'],'png');
close(h);
