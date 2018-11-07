function [peaksignal]=PeakNorm(filename)
load (filename, 'channelData')

[channel1peaks]=findpeaks(channelData(12200:end,1),'MinPeakDistance',16);
[channel2peaks]=findpeaks(channelData(12200:end,2),'MinPeakDistance',16);
q=min([length(channel1peaks) length(channel2peaks)]);
channel1peaks=(channel1peaks(1:q));
channel2peaks=(channel2peaks(1:q));
smoothpeaks1= smooth(channel1peaks,(100/length(channel1peaks)),'lowess');
smoothpeaks2= smooth(channel2peaks,(100/length(channel1peaks)),'lowess');
smoothpeaks1corr=BleachingFit(smoothpeaks1);
smoothpeaks2corr=BleachingFit(smoothpeaks2);
zchannel1peaks= zscore(smoothpeaks1corr);
zchannel2peaks= zscore(smoothpeaks2corr);
 xdata = (0:size(channel1peaks) - 1) / 211;
  figure;plot(xdata, zchannel1peaks, 'g'); hold on;
  plot(xdata, zchannel2peaks, 'r');
 normdata=zchannel1peaks-zchannel2peaks;

 figure; plot(xdata, normdata)

% save filename channelData peaksignal