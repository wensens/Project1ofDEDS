function controlledpetri=controlledpetri(Boutput,Binput,Bc,Mco,M0)
%%
% CONTROLLEDPETRI Generate a "controlled petrinet"
%   controlledpetri=controlledpetri(Boutput,Binput,Bc,Mco)
%   calculate the BBco, Bcpinput, Bcpoutput, and M0Mco of a
%   "controlled Petri net"
%     Def:
%         BBco:The incident matrix of the "controlled Petri net"
%         Bcpinput: The input incident matrix of the "controlled
%         Petri net" 
%         Bcpoutput: The output incident matrix of the
%         "controlled Petri net"
%         M0Mco: The initial state of the "controlled Petri net"
% 
%   see also incident inicon petricon transition Copyright Wensen
%   CNboy @2015

%% 
% Jusge number of input arguments for this function.
% If the number of input argument great than 5, program feedbacks
% the error message below.
if nargin>5
    error('Too many input arguments')
end
% If the number of output argument less than 5, program feedbacks
% the error message below.
if nargin<5
    error('Five input arguments should be given for this function')
end
%% 
if nargin==5%If the number of input arguments equals to 5
    sizeBoutput=size(Boutput);%check the size of Boutput
    sizeBinput=size(Binput);%check the size of Binput
    sizeBc=size(Bc);%check the size of Bc
    boolean.A=sizeBoutput==sizeBinput;
%     Does size of Boutput equals to size of Binput?
    boolean.B=sizeBc(2)==sizeBinput(2);
%     Does columns of Bc equals to columns of Binput?
    if boolean.A==0
%         If size of Boutput does not equal to size of Binput,
%         program feedbacks the error message below.
        error('Boutput and Binput should have same dimension')
    elseif boolean.B==0
%         If columns of Bc does not equal to columns of Binput,
%         programs feedbacks the error message below.
        error('Bc should has same columns with Binput and Boutput')
    else
        signBc=sign(Bc);%checking sign of each entry of Bc
%         Generating two zeros matrix with the dimension same as
%         Bc's dimension.
        controlledpetri.Bcinput=zeros(sizeBc);
        controlledpetri.Bcoutput=zeros(sizeBc);
%         A "for" loop for setting value for entries of Bcinput,
%         the input incident matrix of controller, and Bcoutput,
%         the output incident matrix of controller.
        for i=1:sizeBc(1)%"for" loop for rows
            for j=1:sizeBc(2)%"for" loop for columns
                if signBc(i,j)==-1
                    controlledpetri.Bcinput(i,j)=controlledpetri.Bcinput(i,j)-Bc(i,j);
                    controlledpetri.Bcoutput(i,j)=controlledpetri.Bcoutput(i,j);
                elseif signBc(i,j)==0
                    controlledpetri.Bcinput(i,j)=controlledpetri.Bcinput(i,j);
                    controlledpetri.Bcoutput(i,j)=controlledpetri.Bcoutput(i,j);
                elseif signBc(i,j)==1
                    controlledpetri.Bcinput(i,j)=controlledpetri.Bcinput(i,j);
                    controlledpetri.Bcoutput(i,j)=controlledpetri.Bcoutput(i,j)+Bc(i,j);
                end 
            end
        end
%         Calculating Bcpinput, Bcpoutput, B, BBco, and M0Mco and
%         puting them into structure controlledpetri.
        controlledpetri.Bcpinput=[Binput;controlledpetri.Bcinput];
        controlledpetri.Bcpoutput=[Boutput;controlledpetri.Bcoutput];
        controlledpetri.B=incident(Boutput,Binput);
        controlledpetri.BBco=[controlledpetri.B;Bc];
        controlledpetri.M0Mco=[M0;Mco];
%         For this function, it will return structure
%         controlledpetri to its main program.
    end
end
