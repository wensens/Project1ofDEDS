function petricon=petricon(Boutput,Binput,L,b,M0)
%%
% PETRICON Petri net with controller
%   petricon=petricon(Boutput,Binput,L,b,M0)
%       is used to calculate parameters of petrinet with
%       controller Parameters:
%       petricon.petri.B represents the incident matrix
%       petricon.inicon is a structure that includes initial
%       states of controller
%       Boutput represents the output incident matrix
% 
%   see also controlledpetri incident inicon transition
%   Copyright Wensen&Dan CNboys @2015

%%
% Checking number of input arguments.
if nargin~=5
%     If the number does not equal to 5, program feedbacks the
%     error message below.
    error('Pleas check number of input arguments. It should be 5')
end
%%
if nargin==5%if the number of input arguments equals to 5
    sizeBoutput=size(Boutput);%check the size of Boutput
    sizeBinput=size(Binput);%check the size of Binput
    sizeL=size(L);%check the size of L
    sizeb=size(b);%check the size of b
    sizeM0=size(M0);%check the size of M0
%     Getting logic value for error checking
    petricon.boolean.logisignA1=sizeBinput(1)==sizeBoutput(1);
%     Does rows of Binput equals to rows of Boutput?
    petricon.boolean.logisignA2=sizeBinput(2)==sizeBoutput(2);
%     Does columns of Binput equals to columns of Boutput?
    petricon.boolean.logisignA=petricon.boolean.logisignA1&&petricon.boolean.logisignA2;
%     A equals to "A1 and A2"
    petricon.boolean.logisignB=sizeL(2)==sizeBoutput(1);
%     Does columns of L equals to rows of Boutput?
    petricon.boolean.logisignC=sizeL(1)==sizeb(1);
%     Does rows of L equals to rows of b?
    petricon.boolean.logisignD=sizeM0(1)==sizeBoutput(1);
%     Does rows of M0 equals to rows of Boutput?
%     Checking logic values. 
    if petricon.boolean.logisignA==0
%         If size of Binput does not equals to size of Boutput,
%         program feedbacks the error message below.
        error('Size of Binput should equals to size of Boutput');
    elseif petricon.boolean.logisignB==0
%         If columns of L does not equal to rows of Boutput,
%         program feedbacks the error message below.
        error('Columns of L should equals to rows of Boutput')
    elseif petricon.boolean.logisignC==0
%         If rows of L does not equal to rows of b, program
%         feedbacks the error message below.
        error('Rows of L should equals to rows of b')
    elseif petricon.boolean.logisignD==0
%         If rows of M0 does not equal to rows of Boutput,
%         program feedbacks the error message below.
        error('Please check initial state. It should be a column vector and has same row(s) with row(s) of Boutput')
    else%If there is no error, continue to calculating
%         Calling incident function calculates incident matrix of
%         input incident matrix and output incident matrix of
%         Petri net model.
        petricon.petri.B=incident(Boutput,Binput);
%         Calling inicon function calculates parameters of
%         controller for Petri net
        petricon.controller=inicon(L,b,M0,petricon.petri.B);
        petricon.controller.Bc;
        petricon.controller.Mco;
%         Calling controlledpetri function calculates parameters
%         of "Controlled Petri net"
        petricon.controlledpetri=controlledpetri(Boutput,Binput,petricon.controller.Bc,petricon.controller.Mco,M0);
        petricon.controlledpetri.Bcpinput;
        petricon.controlledpetri.Bcpoutput;
        petricon.controlledpetri.BBco;
        petricon.controlledpetri.M0Mco;
%         Calling transition function calculate Coverability Tree
        petricon.transition=transition(petricon.controlledpetri.Bcpinput,petricon.controlledpetri.BBco,petricon.controlledpetri.M0Mco);
    end
end