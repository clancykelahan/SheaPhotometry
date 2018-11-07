function startPhotometry
    global state
    global vid
    if isempty(state.photometry.saveName)
        return
    end
    warning('you need to add functoinality to add settings to saved data, see how bpod does this');
%    
start(vid)
preview(vid)
state.photometry2.session2.startBackground % start the recording

while ~state.photometry2.session2.IsWaitingForExternalTrigger
    pause(0.1)
end
% release(state.photometry2.session2);
state.photometry.session.startBackground;
tic
% pause(1);
% display(['session 1 is ' num2str(state.photometry.session.IsWaitingForExternalTrigger)]);
display(['session 2 is ' num2str(state.photometry2.session2.IsRunning)]);
% pause(2)
%     outputSingleScan(state.DIO.session,[1])
%     outputSingleScan(state.DIO.session,[0])
