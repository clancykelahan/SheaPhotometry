function processNidaqData(src,event)
% callback function, session assummed to be non-continuous with
% dataAvailableExceeds == SampleRate * Duration
global state


disp('first finished');
disp('executed save callback');

state.mic.micData = [state.mic.micData; event.Data]; % concatenates data vertically (semicolon as operator)
%     state.photometry.TTL = [state.photometry.TTL; TTL];
%outputSingleScan(s,[0])
%     TTLData = state.photometry.TTL;
%     micData = state.mic.micData; % copy structure field so that you can save only the data (limitation of save with structures)
%     save(fullfile(state.photometry.savePath, [state.photometry.saveName(1:end-4) '_Mic.mat']), 'micData');
%     save(fullfile(state.photometry.savePath, [state.photometry.saveName(1:end-4) '_TTL.mat']), 'TTLData');
%
%      pause(2)
   
   
    
    