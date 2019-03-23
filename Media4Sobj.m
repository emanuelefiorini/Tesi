function [media4Sobj]= Media4Sobj(matrixClassCor)
class=4;
epoch = 21;
patient = 107;
media4Sobj = zeros((class*patient),(class*patient));

sobjectMatrix = zeros((class*epoch),(class*epoch));
m=1;
n=1;
for i=1:(class*epoch):size(matrixClassCor,1)
    i
    for k = 1:(class*epoch):size(matrixClassCor,1)
      sobjectMatrix(:,:) = matrixClassCor(i:(i+((class*epoch)-1)),k:(k+((class*epoch)-1))); 
      [media]= Media(sobjectMatrix);
      media4Sobj(m:m+3,n:n+3)= media ;
      n=n+class;
    end
    n=1;
    m=m+class;
end
end