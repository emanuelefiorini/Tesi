function[media]=Media(tmpMatrix)
class = 4; %{Real_L,Real_R,Imagined_L,Imagined_R};
epoch = 21; %calculated as the multiplication of test repetitions (3) and the number of events related to the test (7)
media = zeros(class,class);
 m=1;
 n=1;
 for i = 1:epoch:(epoch*class)
     for k = 1:epoch:(epoch*class)
        M = mean(mean((tmpMatrix(i:(i+(epoch-1)),k:(k+(epoch-1)))))); 
        media(m,n)=M;
        n=n+1;
     end
     n=1;
     m=m+1;
 end
end
 