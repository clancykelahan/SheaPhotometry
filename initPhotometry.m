function initPhotometry       
% function S = initPhotometry(S)

    % state.photometry :: Set up state.photometry data aquisision
    global state
    daq.reset;
    state.mic.micData = [];
    state.mic.session = daq.createSession('ni');
        state.mic.inputChannels{1} = addAnalogInputChannel(state.mic.session,state.mic.device,1 - 1,'Voltage');        
        state.mic.inputChannels{1}.TerminalConfig = 'SingleEnded'; 
    
    state.photometry.session = daq.createSession('ni');
    state.DIO.session = daq.createSession('ni');
    channelsOn = [];
     if state.photometry.channel1On
        channelsOn = [channelsOn 1];
%         state.photometry.inputChannels{1} = addAnalogInputChannel(state.photometry.session,state.photometry.device,1 - 1,'Voltage');        
%         state.photometry.inputChannels{1}.TerminalConfig = 'SingleEnded'; 
        state.photometry.outputChannels{1} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,1 - 1, 'Voltage');
       
     end  
     if state.photometry.channel2On
        channelsOn = [channelsOn 2];
%         state.photometry.inputChannels{2} = addAnalogInputChannel(state.photometry.session,state.photometry.device,2 - 1,'Voltage');        
%         state.photometry.inputChannels{2}.TerminalConfig = 'SingleEnded';         
        state.photometry.outputChannels{2} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,2 - 1, 'Voltage');
       
     end
 
     state.photometry.channelsOn = channelsOn;
%           addClockConnection(state.photometry2.session2,'Dev1/PFI5','external','ScanClock');
     addTriggerConnection(state.photometry.session, 'Dev1/PFI4', 'External', 'StartTrigger'); 
          addDigitalChannel(state.DIO.session,'Dev1','port1/line1','OutputOnly');
    

%         addTriggerConnection(state.photometry2.session2, 'Dev1/PFI4', 'Dev2/PFI0', 'StartTrigger');
%     global state 
%     daq.reset; % I'm testing re-initializing state.photometry with every acquisition- see preparePhotometryAcq
    state.photometry2.channelData = [];
    state.photometry2.session2 = daq.createSession('ni');
    state.DIO2.session2 = daq.createSession('ni');
    % which channels are on?
    channelsOn2 = [];    
    if state.photometry2.channel1On
        channelsOn2 = [channelsOn2 1];
        state.photometry2.inputChannels{1} = addAnalogInputChannel(state.photometry2.session2,state.photometry2.device2,1 - 1,'Voltage');        
        state.photometry2.inputChannels{1}.TerminalConfig = 'SingleEnded';        
%         state.photometry.outputChannels{1} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,1 - 1, 'Voltage'); % - 1 because state.photometry channels are zero based        
    end
    
    if state.photometry2.channel2On
        channelsOn2 = [channelsOn2 2];
        state.photometry2.inputChannels{2} = addAnalogInputChannel(state.photometry2.session2,state.photometry2.device2,2 - 1,'Voltage');        
        state.photometry2.inputChannels{2}.TerminalConfig = 'SingleEnded';
%         state.photometry.outputChannels{2} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,2 - 1, 'Voltage'); % - 1 because state.photometry channels are zero based        
    end
  if state.photometry2.channel3On
        channelsOn2 = [channelsOn2 3];
        state.photometry2.inputChannels{3} = addAnalogInputChannel(state.photometry2.session2,state.photometry2.device2,3 - 1,'Voltage');        
        state.photometry2.inputChannels{3}.TerminalConfig = 'SingleEnded'; 
%         state.photometry.outputChannels{3} = addAnalogOutputChannel(state.photometry.session, state.photometry.device,3 - 1, 'Voltage');
       
     end
    state.photometry2.channelsOn2 = channelsOn2;

%     addClockConnection(state.photometry.session,'external','Dev2/PFI1','ScanClock');
     addTriggerConnection(state.photometry2.session2, 'External', 'Dev2/PFI0', 'StartTrigger');
   
%      

%    if state.photometry.channel3On
%         channelsOn = [channelsOn 3];
%        state.photometry.inputChannels{3} = addAnalogInputChannel(state.photometry.session,state.photometry.device,3 - 1,'Voltage');        
%         state.photometry.inputChannels{3}.TerminalConfig = 'SingleEnded';               
%     end
%     addDigitalChannel(state.DIO.session,'Dev1','port1/line0','OutputOnly');

    
    state.photometry.session.IsContinuous = true;
    state.photometry.session.Rate = state.photometry.sample_rate;
    state.photometry.sample_rate = state.photometry.session.Rate;
    updateLEDData;
    
    state.photometry.session.NotifyWhenScansQueuedBelow = floor(state.photometry.sample_rate) * state.photometry.refreshPeriod; % fire event every second
    state.photometry.session.addlistener('DataRequired', @queueLEDData);
    
    state.mic.session.IsContinuous = true;
    state.mic.session.Rate = state.mic.sample_rate;
    state.mic.sample_rate = state.mic.session.Rate;
    
    state.mic.session.NotifyWhenDataAvailableExceeds = floor(state.mic.sample_rate) * state.mic.refreshPeriod; % fire event every second
    state.mic.session.addlistener('DataAvailable',@processNidaqData);
        
%     
        state.photometry2.session2.IsContinuous = true;
        state.photometry2.session2.Rate = state.photometry2.sample_rate;
        state.photometry2.sample_rate = state.photometry2.session2.Rate;
%         updateLEDData;

        state.photometry2.session2.NotifyWhenDataAvailableExceeds = floor(state.photometry2.sample_rate) * state.photometry2.refreshPeriod; % fire event every second
%         state.photometry2.session2.NotifyWhenScansQueuedBelow = floor(state.photometry2.sample_rate) * state.photometry2.refreshPeriod; % fire event every second
        state.photometry2.session2.addlistener('DataAvailable',@processNidaqData2);
        global k
        k=0;
        global olf_port
        olf_port=serial('com4','baudrate', 9600, 'parity', 'none', 'databits', 8);
        fopen (olf_port);
        numOdor=state.olf.numOdor;
        odorCasette=[1:numOdor]'
        state.olf.odorSeq=[];
        %determines how many trial presentations
        reps=state.olf.presentations-1;
        odorSeq=odorCasette(randperm(length(odorCasette)));
        for c=1:reps
            odorSeq=[odorSeq;odorCasette(randperm(length(odorCasette)))];
        end
        state.olf.odorSeq=odorSeq;
        disp('Initialized');
%         state.photometry2.session2.addlistener('DataRequired', @queueLEDData);

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