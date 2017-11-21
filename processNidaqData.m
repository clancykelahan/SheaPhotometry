function processNidaqData(src,event)
    % callback function, session assummed to be non-continuous with
    % dataAvailableExceeds == SampleRate * Duration
    global state
    
    state.photometry.channelData = [state.photometry.channelData; event.Data]; % concatenates data vertically (semicolon as operator)
    
    channelData = state.photometry.channelData;
    save(fullfile(state.photometry.savePath, state.photometry.saveName));
    

    
    