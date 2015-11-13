clc;
clearvars;
% display=0;
M0=[1 2 3 4];
for i=1:10
    M0=M0+1;
%     cell(i,:)=sprintf('t%d:',i);
    
%     display(i,:)=
    disp(['t',num2str(i),': ',[num2str(M0)]]);
%     sprintf('t%d:',i)
    i=i+1;
end