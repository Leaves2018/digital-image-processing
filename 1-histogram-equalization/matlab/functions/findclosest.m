function [res,res2]=findclosest(num,mat)

[temp,index]=sort(abs(mat-num));
res=mat(index(1));
res2=index(1);