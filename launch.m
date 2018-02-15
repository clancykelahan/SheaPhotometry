%% start the thing from fresh
clear all;
%close all;

global state

% openini('photometry.ini');
initPhotometry;


state.photometry.savePath = 'C:\Users\Steve\Documents\dummydata';
state.photometry.baseName = 'fitzAni';
setSaveName;




%% graph the data after acquiring
%ensureFigure('test', 1); plot((0:size(state.photometry.channelData, 1) - 1) / state.photometry.sample_rate, state.photometry.channelData);
