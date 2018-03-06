%  ensureFigure('test', 1);
%         [b,a] = butter(2,[100/(sample_rate/2)])
%         filtdata1=filtfilt(b,a,channelData(:,1));
%         filtdata2=filtfilt(b,a,channelData(:,2));
%         downData1 = zscore(filtdata1)+4;
%         downData2 = zscore(filtdata2)+4;
%         xdata = (0:size(downData1) - 1) / 6100;
%         plot(xdata, downData1, 'g'); hold on;
%         plot(xdata, downData2, 'r');
%         plot((0:size(channelData, 1) - 1)' / sample_rate, channelData);
%         normdata=downData1./downData2;
%         figure; plot(xdata,normdata)
%         
%         disp('done');
% % % scrapBook
    if size(channelData, 1) >=  30 * sample_rate
        
        ensureFigure('test', 1); plot((0:size(channelData, 1) - 1)' / sample_rate, channelData);
        disp('done');
    end
    sam