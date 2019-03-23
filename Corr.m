function[matrixClassCor]=Corr(dir)
dir;
cd(dir);
if (isfile('Imagined_L.mat') && isfile('Imagined_R.mat') && isfile('Real_L.mat')&& isfile('Real_R.mat'))
    load('Imagined_L.mat');
    load('Imagined_R.mat');
    load('Real_L.mat');
    load('Real_R.mat');
    
else
  % File does not exist.
  warningMessage = sprintf('Warning: file does not exist');
  uiwait(msgbox(warningMessage));
end

% Creation of an matrix "Class" Array  

Class={Real_L,Real_R,Imagined_L,Imagined_R};

A = zeros ((size(Class{1,1},1))*size(Class,2)*(size(Class{1,1},2)),size(Class{1,1},3));
m =(size(Class{1,1},2));

for i = 1 : (size(Class{1,1},1))
  for k =1 : size(Class,2)
        tmp=Class{k};
        A(((m-(size(Class{1,1},2)))+1): m ,:) = squeeze(tmp(i,:,:));
        m = m + (size(Class{1,1},2));     
  end        
 end 
matrixClassCor = corr(A');
end