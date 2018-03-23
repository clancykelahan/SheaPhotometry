function [peaksignal]=PeakNorm(filename)
load (filename, 'channelData')

[channel1peaks]=findpeaks(channelData(:,1),'MinPeakDistance',16);
[channel2peaks]=findpeaks(channelData(:,2),'MinPeakDistance',16);
%[b,a] = butter(2,[10/(211/2)]);
%         filtdata1=filtfilt(b,a,channel1peaks);
%         filtdata2=filtfilt(b,a,channel2peaks);
% zchannel1peaks= zscore(channel1peaks)+5;
% zchannel2peaks= zscore(channel2peaks)+5;
 xdata = (0:size(channel1peaks) - 1) / 211;
  plot(xdata, channel1peaks, 'g'); hold on;
  plot(xdata, channel2peaks, 'r');
 normdata=channel1peaks./channel2peaks;
%  normdata=filtfilt(b,a,normdata);
 figure; plot(xdata, normdata)

% save filename channelData peaksignal