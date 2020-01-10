function startPhotometry
    global state
    global vid
    global nest_cam
    global mic_mark
    global nest_cam_mark
    if isempty(state.photometry.saveName)
        return
    end
    warning('you need to add functoinality to add settings to saved data, see how bpod does this');
%    
preview(vid)

%start second camera (nest camera)
if nest_cam_mark==1
start(nest_cam)
preview(nest_cam)
disp('nest cam ON');
end
%Ultrasound recording 

if mic_mark==1  
state.mic.session.startBackground;
disp('Recording Ultrasound');
else
    disp('US rec Off');
end

start(vid)


state.photometry2.session2.startBackground

 % start the recording
while state.photometry2.session2.IsWaitingForExternalTrigger
%     pause(0.1)
end

% release(state.photometry2.session2);
state.photometry.session.startBackground;
global miniscope
outputSingleScan(miniscope,[1]);
% tic
% pause(1);
% display(['session 1 is ' num2str(state.photometry.session.IsWaitingForExternalTrigger)]);
display(['session 2 is ' num2str(state.photometry2.session2.IsRunning)]);
% pause(2)
%     outputSingleScan(state.DIO.session,[1])
%     outputSingleScan(state.DIO.session,[0])
