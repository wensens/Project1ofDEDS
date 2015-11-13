function inicon=inicon(L,b,M0,B)
%%
% INICON initial state and marking of Petri net controller
%     inicon=inicon(L,b,M0,B)
%         is used to calculate parameters of petri net controller
%         parameters:
%         inicon.Bc represents the incident matrix of petri net
%         controller
%         inicon.Mco represents the initial states of petri net
%         controller 
% 
%         Inputs: 
%         L and b: L*M<=b;
%         M0: the initial state of petri net. 
%         B: the incident matrix of petri net
%         
%     see also controlledpetri incident petricon transition
%     Copyright Wensen CNboy @2015

%%
% Checking number of input arguments for this function 
% If the number of input arguments great than 4, program
% feedbacks the error message below.
if nargin>4
    error('Too many input arguments');
end
% If the number of input arguments less than 4, program feedbacks
% the error message below
if nargin<4
    error('This function should have four inputs');
end
%%
if nargin==4%If the number of input arguments equals to 4
%     Saving size value of L, b, M0, and B to it corresponding
%     variable prepare for the logic check.
    sizeL=size(L);%check the size of L
    sizeb=size(b);%check the size of b
    sizeM0=size(M0);%check the size of M0
    sizeB=size(B);%check the size of B
%     Getting logic value for error checking
    inicon.boolean.logisignA1=sizeM0(1)==sizeB(1);
%     Does rows of M0 equals to rows of B?
    inicon.boolean.logisignA2=sizeM0(2)==1;
%     Does M0 is a column vector?
    inicon.boolean.logisignA=inicon.boolean.logisignA1&&inicon.boolean.logisignA2;
%     A equals to "A1 and A2"
    inicon.boolean.logisignB=sizeL(2)==sizeB(1);
%     Does columns of L equal to rows of B?
    inicon.boolean.logisignC1=sizeb(1)==sizeL(1);
%     Does rows of b equals to rows of L?
    inicon.boolean.logisignC2=sizeb(2)==sizeM0(2);
%     Does b is a column vector?
    inicon.boolean.logisignC=inicon.boolean.logisignC1&&inicon.boolean.logisignC2;
%     C equals to "C1 and C2" 
%     Checking logic values. 
    if inicon.boolean.logisignA==0
%         If rows of M0 does not equal to rows of B, program
%         feedbacks the error message below. If M0 is not a
%         column vector, program also feedbacks the error message
%         below.
        error('Rows of column vector M0 should equal to as rows of B')
    elseif inicon.boolean.logisignB==0
%         If columns of L does not equal to rows of B, program
%         feedbacks the error message below
        error('Columns of coefficient matrix of constraint should equal to rows of B')
    elseif inicon.boolean.logisignC==0
%         If rows of b does not equal to rows of L or b is not a
%         column vector, program feedbacks the error message
%         below.
        error('b should be a scale or a column vector with rows same as rows of L')
    else
%         According to state-based control of Petri nets,
%         calculate the incident matrix of controller and initial
%         state of controller to design a controller for a Petri
%         net.
        inicon.Bc=-L*B;
        inicon.Mco=b-L*M0;
%         For this function, it will return the inicon structure
%         for its main program. The inicon structure include the
%         incident matrix of controller that called inicon.Bc and
%         the initial state of controller that called inicon.Mco.
        
    end
end
