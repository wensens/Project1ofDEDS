clc
clearvars
Binput=[1 0 0 0;0 0 1 0;0 1 0 1]
Boutput=[0 0 0 1;1 1 0 0;0 0 1 0]
L=[0 1 1 ]
b=2
M0=[4 0 0]'


petricon=petricon(Boutput,Binput,L,b,M0);
Bc=petricon.controller.Bc
Mco=petricon.controller.Mco

Bcpinput=petricon.controlledpetri.Bcpinput
Bcpoutput=petricon.controlledpetri.Bcpoutput;
BBco=petricon.controlledpetri.BBco
M0Mco=petricon.controlledpetri.M0Mco
Mall=petricon.transition.Mall
Tall=petricon.transition.Tall
DT=petricon.transition.DT
% T = [DT,'*',Mall,'*',Tall]
% writetable(T,'wensdemo1.txt')
% type 'wensdemo1.txt'
% xlswrite('wensdemo',T)

%%%%%%%%%%show data%%%%%%%%%%
sizeDT=size(DT);
Mallstr=num2str(Mall);
Tallstr=num2str(Tall);
head=' node      each         transition \n kinds    states        sequences'
fid=fopen('wensendemo2.txt','wt');
fprintf(fid,[head '\n']);

for i=1:sizeDT(1)
    fprintf(fid,' %d        %d %d %d %d        %d %d %d %d %d\n',...
        DT(i,1),Mall(i,:),Tall(i,:));
end
fclose(fid);