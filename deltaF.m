% function [deltaF] = deltaF(datafile)
% load(datafile, 'channelData');

channelData=state.photometry2.channelData;
channelData=channelData(6101:end,:);
sample_rate = 211;
figure;plot(channelData(:,1),'g');hold;
plot(channelData(:,2),'r');
channelData1=findpeaks(channelData(:,1),'MinPeakDistance',21);
channelData2=findpeaks(channelData(:,2),'MinPeakDistance',21);
dim=min([length(channelData1) length(channelData2)]); 
% [b,a] = butter(2,[40/(sample_rate/2)]);
%improved low-pass filter from 40 to 15;
[b,a] = butter(2,[15]/(sample_rate/2),'low');
filtdata1=filtfilt(b,a,channelData1(1:dim));
filtdata2=filtfilt(b,a,channelData2(1:dim));
xdata = (0:dim - 1) / 211;
cf1=fit(xdata',filtdata1,'exp2');
figure; plot (xdata,filtdata1,'g');hold on;
plot(xdata,cf1(xdata),'b');
bleach1= cf1(xdata)-min(cf1(xdata));
filtdata1 = (filtdata1-bleach1);
cf2=fit(xdata',filtdata2,'exp2');
figure; plot (xdata,filtdata2,'r');hold on;
plot(xdata,cf2(xdata),'b');
bleach2= cf2(xdata)-min(cf2(xdata));
filtdata2 = filtdata2-bleach2;
figure; plot (xdata,filtdata1,'g');hold on;
plot (xdata,filtdata2,'r');

 
figure;scatter(filtdata2,filtdata1)
[b]=robustfit(filtdata2,filtdata1);
m=b(2);b=b(1);
hold ;plot([min(filtdata2):0.01:max(filtdata2)], m*([ min(filtdata2):0.01:max(filtdata2)]) + b,'r')
filtdata1pr= m*(filtdata2) + b;
figure; plot (filtdata1,'g');hold;plot(filtdata1pr,'r');
blf = mean(filtdata1pr);
filtdata1pr= filtdata1pr-blf;
%tiny difference of predicted curve from avg baseline ^
normdata=filtdata1-filtdata1pr;
deltaF = (normdata-blf)/blf;
figure;plot(xdata,deltaF);
% save (datafile,'deltaf','-append');