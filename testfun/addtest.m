function addtest=addtest(a,b)
sizea=size(a);
sizeb=size(b);
if sizea~=sizeb
    error('keep dimension of two matrix same');
else
    addtest.add=a+b;
    addtest.min=a-b;
end
end
