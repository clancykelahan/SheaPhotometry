% scrapBook
    if size(state.photometry.channelData, 1) >=  30 * state.photometry.sample_rate
        state.photometry.session.stop;
        ensureFigure('test', 1); plot((0:size(state.photometry.channelData, 1) - 1)' / state.photometry.sample_rate, state.photometry.channelData);
        disp('done');
    end
    

        
 
%         ensureFigure('test', 1);
%         downData1 = decimate(state.photometry.channelData(:,1), 305);
%         downData2 = decimate(state.photometry.channelData(:,2), 305);
%         downData1 = zscore(downData1);
%         downData2 = zscore(downData2);
%         xdata = (0:size(downData1) - 1) / 20;
%         plot(xdata, downData1, 'g'); hold on;
%         plot(xdata, downData2, 'r');
%         plot((0:size(state.photometry.channelData, 1) - 1)' / state.photometry.sample_rate, state.photometry.channelData);
%         
%         disp('done');
