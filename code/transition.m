 function transition=transition(Bcpinput,BBco,M0Mco)
%%
% TRANSITION Transition of a "Controlled Petri net"
%   transition=transition(Bcpinput,BBco,M0Mco) calculate all
%   states in Coverability Tree.
%     Def:
%         Bcpinput: input incident matrix of "Controlled Petri
%         net".
%         BBco: incident matrix of "Controlled Petri net".
%         M0Mco: initial state of "Controlled Petri net".
% 
%   see also controlledpetri incident inicon petricon
%   Copyright Wensen CNboy @2015

%%
sizeBcpinput=size(Bcpinput);%checking the size of Bcpinput

% Generating a identity matrix with the dimension of columns of
% Bcpinput by the columns of Bcpinput
V=eye(sizeBcpinput(2));

% initialize M0McoT, which used to store state(s) for next
% time fire by enabled transition, to the initial state.
M0McoT=M0Mco';
sizeM0McoT=size(M0McoT);%checking the size of M0McoT
Mi=1;% initialize Mi to 1
% Mi is used as a pointer to point the row of Mall which help to
% store all state into correct place in Mall.
transition.Mall(Mi,:)=M0McoT;%store initial state into Mall

Ti=1;% initialize Ti to 1
% Ti is used as a pointer to point the row of Tall which help to
% store all transition sequence into correct place in Tall.
transition.Tall(Ti)=0;
% store 0 as there is no transition sequence to the initial state

%%
%DT(i)=0 represents the state is a fireable state.
%DT(i)=1 represents the state is a duplicate node.
%DT(i)=2 represents the state is a terminal node.
DTi=1;%initialize DTi to 1
% DTi is used as a pointer to point the row of DT which help to
% store kind of all state into correct place in DT.

% Flag is used as a flag to determine whether continue to next
% fire. If the flag equal to 0, program stop.

% Ddetect is used to store DT value in one transition, Which is
% used to determine whether to fire next transition for all state
% obtained in last time transition.

%%
% "for" loop is used to determin the initial value of
% transition.DT(DTi,:), Ddetect, and flag.
for i=1:sizeM0McoT(1)
    for j=1:sizeBcpinput(2)
        if M0McoT(i,:)'<Bcpinput(:,j)
            transition.DT(DTi,:)=2;
            Ddetect=1;
            flag=0;
        else
            transition.DT(DTi,:)=0;
            Ddetect=0;
            flag=1;
        end
    end
end

% Dtistart is used to help store transition sequence to Tall.
% Initialize DTistart to 2, since we will not use it at very
% begin of this program.
DTistart=2;
%%
while flag~=0
%     initialize Tistart to DTistart in each time of loop
    Tistart=DTistart;
%     check the size of M0McoT for each time of loop
    sizeM0McoT=size(M0McoT);
%     n helps to store M to M0Mco, initialize it to 1 at begining
%     of each time of loop.
    n=1;
% start a "for" loop from 1 to the rows of M0McoT
    for i=1:sizeM0McoT(1)
% Use Ddetect to determine whether the state can be fire by any
% transition of the Petri net.
        if Ddetect(i)==0
%             So the state can be fired by some transition
            for j=1:sizeBcpinput(2)
%                 Start a "for" loop from 1 to the columns of
%                 Bcpinput, the input incident matrix of
%                 "Controlled Petri net.
                if M0McoT(i,:)'>=Bcpinput(:,j)
%                     If the transpose of state i can be fired by
%                     the j transition,
                    sizeTallold=size(transition.Tall);    
                    Ti=Ti+1;
                    sizeTall=size(transition.Tall);
%                     use flag to help storing transition
%                     sequence to Tall.
                    if flag>=2
                        for f=1:flag-1
                            transition.Tall(Ti,f)=transition.Tall(Tistart,f);
                        end
                    end
                    transition.Tall(Ti,flag)=j;
%                     iterate DTistart
                    sizeTallnew=size(transition.Tall);
                    if sizeTallnew(2)==sizeTallold(2)+1
                        DTistart=Ti;
                    end
%                     storing M to Mall
                    M=M0McoT(i,:)'+BBco*V(:,j);
                    Mi=Mi+1;
                    transition.Mall(Mi,:)=M';

                    sizeMall=size(transition.Mall);
%                     iterate DTi
                    DTi=DTi+1;
                    transition.DT(DTi,:)=0;
%                     storing the value that represents the state
%                     kind to DT.
                    for k=1:sizeMall(1)-1
%                         Checking whethe the state is a
%                         duplicate state. If it is a duplicate
%                         state, writing 1 to the corresponding
%                         place in DT.
                        if M'==transition.Mall(k,:)
                            transition.DT(DTi,:)=1;
                        end
                    end
%                     initialization Mdetect to a zeros matrix,
%                     which is used to check whether the state is
%                     a terminal state. If it is a terminal
%                     state, writing 2 to the corresponding place
%                     in DT.
                    Mdetect=zeros(1,sizeBcpinput(2));
                    for m=1:sizeBcpinput(2)%"for" loop
%                         If M less than each column of Bcpinput,
%                         it is a terminal state. each m of M
%                         will be written to 1
                        if M>=Bcpinput(:,m)
                            Mdetect(1,m)=0;
                        else
                            Mdetect(1,m)=1;
                        end
                    end
                    if Mdetect>=1
                        transition.DT(DTi)=2;
                    else
                        transition.DT(DTi)=transition.DT(DTi);
                    end
                    M0Mco(:,n)=M;%store M to M0Mco
                    n=n+1;
                end
            end
        end
        Tistart=Tistart+1;
    end
    M0McoT=[];
    M0McoT=M0Mco';
    M0Mco=[];
    Ddetect=[];
    Ddetect=transition.DT(DTistart:DTi,:);
    if Ddetect>=1
        flag=0;
    else
        sizeTall=size(transition.Tall);
        flag=flag+1;
    end
end

        

