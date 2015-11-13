clc
clearvars
%%
% input initial conditions for petri net in this section
% input incident matrix of Petri net model for movement of cat
Bcatinput=[1 0 0 0 0 0;0 1 1 0 0 0;0 0 0 1 1 0;0 0 0 0 0 1];
% output incident matrix of Petri net model for movement of cat
Bcatoutput=[0 1 0 1 0 0;1 0 0 0 0 0;0 0 0 0 0 1;0 0 1 0 1 0];
% input incident matrix of Petri net model for movement of mouse
Bmouseinput=[1 0 1 0 0 0;0 1 0 0 0 0;0 0 0 1 0 0;0 0 0 0 1 1];
%  output incident matrix of Petri net model for movement of
%  mouse
Bmouseoutput=[0 1 0 0 0 0;1 0 0 0 0 1;0 0 1 0 1 0;0 0 0 1 0 0];
% generating a zeros matrix which has same dimension with above
% matrix's dimension
zeros46=zeros(4,6);
% calculate input incident matrix of "Cat and Mouse" problem
Binput=[Bcatinput,zeros46;zeros46,Bmouseinput]
% calculate output incident matrix of "Cat and Mouse" problem
Boutput=[Bcatoutput,zeros46;zeros46,Bmouseoutput]
% generate a 4 by 4 identical matrix 
eye4=eye(4);
% input coefficient matrix of constraint
L=[eye4,eye4]
% generate a 4 by 1 ones matrix
ones41=ones(4,1);
% input column vector of constraint
b=ones41
% input initial state of "Cat and mouse" Petri net
M0=[0 0 0 1 1 0 0 0]'

%%
% calculate initial states of controller.
% problem and reachable state of the "Controlled Petri net"
% Call functions, petricon.
petricon=petricon(Boutput,Binput,L,b,M0);
% parameters of controller
Bc=petricon.controller.Bc
Mco=petricon.controller.Mco
% incident matrix of "Controlled Petri net"
Bcpinput=petricon.controlledpetri.Bcpinput
Bcpoutput=petricon.controlledpetri.Bcpoutput;
BBco=petricon.controlledpetri.BBco
M0Mco=petricon.controlledpetri.M0Mco
% all states, all transition sequences, and the kind of state
Mall=petricon.transition.Mall%each row is a marking state
Tall=petricon.transition.Tall
% each row of Tall represents a transition sequence to the
% corresponding row in Mall.
DT=petricon.transition.DT
% each row of DT represents the kind of state to the
% corresponding row in Mall
%% 
% This section generate a txt file for the results
%%%%%%%%%%show data%%%%%%%%%%
sizeDT=size(DT);
head=' node      each                       transition \n kinds    states                       sequences';
fid=fopen('cat and mouse.txt','wt');
fprintf(fid,[head '\n']);
for i=1:sizeDT(1)
    fprintf(fid,' %d        %d %d %d %d %d %d %d %d %d %d %d %d         %d %d %d \n',...
        DT(i,1),Mall(i,:),Tall(i,:));
end
fclose(fid);