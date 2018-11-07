function processNidaqData2(src,event)
    % callback function, session assummed to be non-continuous with
    % dataAvailableExceeds == SampleRate * Duration
    global state
    disp('second session');
    
   state.photometry2.channelData = [state.photometry2.channelData; event.Data]; % concatenates data vertically (semicolon as operator)
    
    %outputSingleScan(s,[0])
    channelData = state.photometry2.channelData; % copy structure field so that you can save only the data (limitation of save with structures)
    save(fullfile(state.photometry.savePath, state.photometry.saveName), 'channelData');
    
% pause(2)
%         outputSingleScan(state.DIO2.session2,[1])
%     outputSingleScan(state.DIO2.session2,[0])