function updateLEDData
    % updated 4/21/2017
    global state
    
    nSamples = ceil(state.photometry.refreshPeriod * state.photometry.sample_rate);
    outputData = zeros(nSamples, length(state.photometry.channelsOn)); % preallocated output data
    for channel = state.photometry.channelsOn
        outputData(:,channel) = ones(nSamples, 1) * state.photometry.(['channel' num2str(channel) 'Amp']);
    end
    outputData(end,:) = 0;
    
    state.photometry.session.queueOutputData(outputData);
    
    

%     % generate output data
%     nidaq.dt = 1/nidaq.sample_rate;    
%     t = (0:nidaq.dt:nidaq.duration - nidaq.dt)'; %last sample starts dt prior to t = duration
%     nidaq.ao_data = [];
%     ref = struct(...
%         'phaseShift', [],...
%         'freq', [],...
%         'amp', []...
%         );
%     for ch = nidaq.channelsOn
%         phaseShift = rand(1) * 2 * pi;
%         freq = S.nidaq.(['LED' num2str(ch) '_f']);
%         amp = S.GUI.(['LED' num2str(ch) '_amp']);
%         channelData = (sin(2*pi*freq*t + phaseShift) + 1) /2 * amp;
% %         channelData = [channelData; 0];
%         channelData(end) = 0;
%         nidaq.ao_data = [nidaq.ao_data channelData];
%         ref.phaseShift(end + 1) = phaseShift;
%         ref.freq(end + 1) = freq;
%         ref.amp(end + 1) = amp;
%     end
%     ref.channelsOn = nidaq.channelsOn;
%     nidaq.ref = ref;
%     nidaq.session.queueOutputData(nidaq.ao_data);