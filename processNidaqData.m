function processNidaqData(src,event)
    % callback function, session assummed to be non-continuous with
    % dataAvailableExceeds == SampleRate * Duration
    global state
    disp('executed save callback');
    
    
    state.photometry.channelData = [state.photometry.channelData; event.Data]; % concatenates data vertically (semicolon as operator)
    
    %outputSingleScan(s,[0])
    channelData = state.photometry.channelData; % copy structure field so that you can save only the data (limitation of save with structures)
    save(fullfile(state.photometry.savePath, state.photometry.saveName), 'channelData');
    pause(2)
        outputSingleScan(state.DIO.session,[1])
    outputSingleScan(state.DIO.session,[0])

    

    
    