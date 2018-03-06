%Use for windows computers
function Video
global state
global vid
vid = videoinput('winvideo', 1);
%Saves videos straight to disk
vid.LoggingMode = 'disk';

vid.FramesPerTrigger = Inf;

str = state.photometry.savePath;
str1 = state.photometry.saveName(1:end-4);
str2 = '.avi';
str3 = strcat(str,str1,str2);
logfile = VideoWriter(str3);
vid.DiskLogger = logfile;
