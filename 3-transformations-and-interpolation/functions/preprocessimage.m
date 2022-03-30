function RESULT=preprocessimage(IMAGE,N)
%PREPROCESSIMAGE Enlarge the image by N-circle pixels.
%   RESULT=preprocessimage(IMAGE,N) enlarges the IMAGE by N-circle pixels.
%   For example, if the size of IMAGE is (98,98) and N is 1, the size of
%   RESULT will be (100, 100). The new added pixel will use the pixel value
%   of the pixel of the original image closest to it as its own value.
%
%   Note
%   ----
%   PREPROCESSIMAGE is only a precautionary measure to prevent
%   cross-borders and should not be used for output images.
[rows,cols,channels]=size(IMAGE);
RESULT=uint8(zeros(rows+2*N,cols+2*N,channels));
for k=1:channels
    % process original image
    RESULT(N+1:N+rows,N+1:N+cols,k)=IMAGE(:,:,k);
    % process four lines
    RESULT(1:N,N+1:N+cols,k)=repmat(IMAGE(1,:,k),N,1);
    RESULT(N+rows+1:2*N+rows,N+1:N+cols,k)=repmat(IMAGE(rows,:,k),N,1);
    RESULT(N+1:N+rows,1:N,k)=repmat(IMAGE(:,1,k),1,N);
    RESULT(N+1:N+rows,N+cols+1:2*N+cols,k)=repmat(IMAGE(:,cols,k),1,N);
    % process four corners
    RESULT(1:N,1:N,k)=IMAGE(1,1,k);
    RESULT(1:N,N+cols+1:2*N+cols,k)=IMAGE(1,cols,k);
    RESULT(N+rows+1:2*N+rows,1:N,k)=IMAGE(rows,1,k);
    RESULT(N+rows+1:2*N+rows,N+cols+1:2*N+cols,k)=IMAGE(rows,cols,k);
end