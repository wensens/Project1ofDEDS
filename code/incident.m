function incident=incident(Boutput,Binput)
%%
% INCIDENT Incident matrix of petri net
%   incident=incident(Boutput,Binput) calculate the incident
%   matrix
%     Def:
%         B=Boutput-Binput
%         B represents the incident matrix
%         Binput represents the input incident matrix
%         Boutput represents the output incident matrix
% 
%   see also controlledpetri inicon petricon transition
%   Copyright Wensen CNboy @2015

%%
% Checking number of input arguments for this function 
% If the number of input arguments great than 2, program
% feedbacks the error message below
if nargin>2
    error('Too many input arguments')
end
% If the number of input arguments less than 2, program feedbacks
% the error message below.
if nargin<2
    error('Two matrix should be given for this function')
end
%%
if nargin==2%If the number of input arguments equals to 2
    sizeBoutput=size(Boutput);%check the size of Boutput
    sizeBinput=size(Binput);%check the size of Binput
%     Checking the size of Boutput and the size of Binput.
%     If they are not equaled, program feedbacks the error
%     message below.
    if sizeBoutput~=sizeBinput
        error('Check dimensions of Binput and Boutput and keep them same')
    end
%     If the size of Boutput and Binput are equal, calculate the
%     incident matrix of the Petri net defined by Boutput and
%     Binput.
    if sizeBoutput==sizeBinput
%         For a Petri net, the incident matrix equals the output
%         incident matrix minus the input incident matrix.
%         For this function, it will return incident value to its
%         main program.
        incident=Boutput-Binput;
    end
end
