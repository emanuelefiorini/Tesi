clc
clear

inDir='C:\Users\Emanuele\Desktop\Data_Set\www.physionet.org\pn4\eegmmidb\';



fil_sbj= 'S*';

cases = dir(fullfile(inDir,fil_sbj));
ts=['*R04.edf';'*R08.edf';'*R12.edf'];  %vector of Task2
% ts=['*R03.edf';'*R07.edf';'*R11.edf']; % vector of Task1i

lf = 13; %this is for beta band
hf = 30; %this is for beta band
maxf = 40;  %this is for total power comp
eeg_channel = 64;  
min_event = 7; %works for sbjs with at least 7 events -


% here you save the results for T1 e T2 
fingerprint_t1=zeros(length(cases),size(ts,1),min_event,eeg_channel); 
fingerprint_t2=zeros(length(cases),size(ts,1),min_event,eeg_channel);

for i=1:length(cases)
    i
    for j=1:size(ts,1)
        fil_tsk=ts(j,:);
        curr_edf=dir(fullfile(strcat(inDir,cases(i).name,'/'),fil_tsk));
        file_to_open=strcat(inDir,cases(i).name,'/',curr_edf.name);   
        [eeg, header]=ReadEDF(file_to_open);
        EEG_Signal =(cell2mat(eeg))';
        t1=1;
        t2=1;        
        for ev=1:length(header.annotation.event)
            if strcmp(header.annotation.event{ev},'T1') && t1<(min_event+1)                
                my_curr_data= EEG_Signal(:,header.annotation.starttime(ev)*header.samplerate(1):header.annotation.starttime(ev)*header.samplerate(1)+header.annotation.duration(ev)*header.samplerate(1));
                [Pxx,F] = pwelch(my_curr_data',[],[],[],header.samplerate(1));
                [low,indlow]=min(abs(F-lf));
                [high,indhigh]=min(abs(F-hf));
                [max,indmax]=min(abs(F-maxf));
                band_relative=sum(Pxx(indlow:indhigh,:))./sum(Pxx(1:indmax,:));
                fingerprint_t1(i,j,t1,:)=band_relative;
                t1=t1+1;
            end
            if strcmp(header.annotation.event{ev},'T2') && t2<(min_event+1)                
                my_curr_data=EEG_Signal(:,header.annotation.starttime(ev)*header.samplerate(1):header.annotation.starttime(ev)*header.samplerate(1)+header.annotation.duration(ev)*header.samplerate(1));
                [Pxx,F] = pwelch(my_curr_data',[],[],[],header.samplerate(1));
                [low,indlow]=min(abs(F-lf));
                [high,indhigh]=min(abs(F-hf));
                [max,indmax]=min(abs(F-maxf));
                band_relative=sum(Pxx(indlow:indhigh,:))./sum(Pxx(1:indmax,:));
                fingerprint_t2(i,j,t2,:)= band_relative;
                t2=t2+1;
            end
        end    
    end       
end
% Real_L = reshape(fingerprint_t1,i,(j*min_event), eeg_channel);
% Real_R = reshape(fingerprint_t2,i,(j*min_event), eeg_channel);
Imagined_L = reshape(fingerprint_t1,i,(j*min_event),eeg_channel);
Imagined_R = reshape(fingerprint_t2,i,(j*min_event),eeg_channel);

% Correlation matrix among subjects derived from 
% Pearson pair-wise cross-correlation matlab between 4 Class

dir = 'C:\Users\Emanuele\Desktop\risultati';

[matrixClassCor]=Corr(dir);

[media4Sobj]= Media4Sobj(matrixClassCor);