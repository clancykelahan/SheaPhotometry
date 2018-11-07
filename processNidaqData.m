function processNidaqData(src,event)
    % callback function, session assummed to be non-continuous with
    % dataAvailableExceeds == SampleRate * Duration
    global state
    outputSingleScan(state.DIO.session,[1])
    outputSingleScan(state.DIO.session,[0])
%     TTL=toc;
disp('first finished');
    disp('executed save callback');
      
    state.photometry.micData = [state.photometry.micData; event.Data]; % concatenates data vertically (semicolon as operator)
%     state.photometry.TTL = [state.photometry.TTL; TTL];
    %outputSingleScan(s,[0])
%     TTLData = state.photometry.TTL;
    micData = state.photometry.micData; % copy structure field so that you can save only the data (limitation of save with structures)
    save(fullfile(state.photometry.savePath, [state.photometry.saveName(1:end-4) '_Mic.mat']), 'micData');
%     save(fullfile(state.photometry.savePath, [state.photometry.saveName(1:end-4) '_TTL.mat']), 'TTLData');
%     
%      pause(2)
   
   
    
    