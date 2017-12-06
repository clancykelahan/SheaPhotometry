function initPhotometry       
% function S = initPhotometry(S)
    %% state.photometry :: Set up state.photometry data aquisision
    global state

    daq.reset; % I'm testing re-initializing state.photometry with every acquisition- see preparePhotometryAcq
    state.photometry.channelData = [];
    state.photometry.session = daq.createSession('ni');
    % which channels are on?
    channelsOn = [];    
    if state.photometry.channel1On
        channelsOn = [channelsOn 1];
        state.photometry.inputChannels{1} = addAnalogInputChannel(state.photometry.session,state.photometry.device,1 - 1,'Voltage');        
        state.photometry.inputChannels{1}.TerminalConfig = 'SingleEnded';        
        state.photometry.outputChannels{1} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,1 - 1, 'Voltage'); % - 1 because state.photometry channels are zero based        
    end
    
    if state.photometry.channel2On
        channelsOn = [channelsOn 2];
        state.photometry.inputChannels{2} = addAnalogInputChannel(state.photometry.session,state.photometry.device,2 - 1,'Voltage');        
        state.photometry.inputChannels{2}.TerminalConfig = 'SingleEnded';
        state.photometry.outputChannels{2} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,2 - 1, 'Voltage'); % - 1 because state.photometry channels are zero based        
    end    
    state.photometry.channelsOn = channelsOn;
    


    
    state.photometry.session.IsContinuous = true;
    state.photometry.session.Rate = state.photometry.sample_rate;
    state.photometry.sample_rate = state.photometry.session.Rate;
    updateLEDData;
    
    state.photometry.session.NotifyWhenDataAvailableExceeds = floor(state.photometry.sample_rate) * state.photometry.refreshPeriod; % fire event every second
    state.photometry.session.NotifyWhenScansQueuedBelow = floor(state.photometry.sample_rate) * state.photometry.refreshPeriod; % fire event every second
    state.photometry.session.addlistener('DataAvailable',@processNidaqData);
    state.photometry.session.addlistener('DataRequired', @queueLEDData);    


    % now session is re-created each trial 5/30/17, lines below no longer
    % needed
%     %% Set up session and channels
%     state.photometry.session = daq.createSession('ni');
%     
% 
%     %% add inputs
%     counter = 1;
%     for ch = state.photometry.ai_channelNames
%         state.photometry.aiChannels{counter} = addAnalogInputChannel(state.photometry.session,S.state.photometry.Device,ch,'Voltage');
%         state.photometry.aiChannels{counter}.TerminalConfig = 'SingleEnded';
%         counter = counter + 1;
%     end
%     %% add outputs
%     counter = 1;
%     for ch = state.photometry.ao_channelNames
%         state.photometry.aoChannels{counter} = state.photometry.session.addAnalogOutputChannel(S.state.photometry.Device,ch, 'Voltage');
%         counter = counter + 1;
%     end
% 
%     %% add trigger external trigger, if specified
%     if S.state.photometry.TriggerConnection
%         addTriggerConnection(state.photometry.session, 'external', [S.state.photometry.Device '/' S.state.photometry.TriggerSource], 'StartTrigger');
%         state.photometry.session.ExternalTriggerTimeout = 900; % something really long (15min), might be necessary during freely moving behavior when animal doesn't re-initiate trial for a while
%     end
%     
%     %% Sampling rate and continuous updating (important for queue-ing ao data)
%     state.photometry.session.Rate = state.photometry.sample_rate;
%     state.photometry.session.IsContinuous = false;
%     
%     %% create and cue data for output, add callback function
%     updateLEDData(S); 
%     % data available notify must be set after queueing data
%     state.photometry.session.NotifyWhenDataAvailableExceeds = state.photometry.duration * state.photometry.sample_rate; % at end of complete acquisition     
%     lh{1} = state.photometry.session.addlistener('DataAvailable',@processstate.photometryData);
% 
%   