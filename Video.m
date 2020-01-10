%Use for windows computers
function Video
global state
global vid

vid = videoinput('winvideo', 1,'MJPG_640x480');
%vid = videoinput('winvideo', 1,'MJPG_1280x720'); %Yunyao - for rat cage recording
%Saves videos straight to disk
vid.LoggingMode = 'disk';

vid.FramesPerTrigger = Inf;

str = state.photometry.savePath;
str1 = state.photometry.saveName(1:end-4);
str2 = '.avi';
str3 = strcat(str,str1,str2);
%logfile = VideoWriter(str3);

%Roman
logfile = VideoWriter(str3,'MPEG-4');

vid.DiskLogger = logfile;

% Roman
% when using a second camera (nest camera)
global nest_cam_mark
global nest_cam

if nest_cam_mark==1
nest_cam = videoinput('winvideo', 2,'MJPG_640x480');
nest_cam.LoggingMode = 'disk';
nest_cam.FramesPerTrigger = Inf;
st = state.photometry.savePath;
st1 = state.photometry.saveName(1:end-4);
st2='(nest_cam)';
st3 = strcat(st,st1,st2);
logfile = VideoWriter(st3,'MPEG-4');
nest_cam.DiskLogger = logfile;
end
