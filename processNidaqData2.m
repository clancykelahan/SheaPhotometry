function processNidaqData2(src,event)
    % callback function, session assummed to be non-continuous with
    % dataAvailableExceeds == SampleRate * Duration
    
    global state
%     disp('second session');
    global olf_port 
    global k
    global TTL_timer 
    global speakerSession
    global stims
    k=k+1;
    b=mod(k,3);
    if b==0
        state.olf.counter=state.olf.counter+1;
        odorchan=state.olf.odorSeq(state.olf.counter);
        delay=state.olf.delay;
        duration=state.olf.duration;
        fprintf(olf_port, '%i,%i,%i,%s',[odorchan delay duration newline]);
          disp('puff');

        %Roman TTL start
%         start(TTL_timer);
    end
%          
   state.photometry2.channelData = [state.photometry2.channelData; event.Data]; % concatenates data vertically (semicolon as operator)
  
   state.US.counter=state.US.counter+1;
   stimID=state.US.stimSeq(state.US.counter);
   stim=stims.Stims{1,stimID};
   queueOutputData(speakerSession,stim);
        startBackground(speakerSession);
         disp('peep');
        
% pause(5)
% state.US.counter=state.US.counter+1;
%    stimID=state.US.stimSeq(state.US.counter);
%    stim=stims.Stims{1,stimID}; 
%    queueOutputData(speakerSession,stim);
%         startBackground(speakerSession);
%         disp('peep');
    %outputSingleScan(s,[0])
%     channelData = state.photometry2.channelData; % copy structure field so that you can save only the data (limitation of save with structures)
%     save(fullfile(state.photometry.savePath, state.photometry.saveName), 'channelData');
    
% pause(2)
%         outputSingleScan(state.DIO2.session2,[1])
%     outputSingleScan(state.DIO2.session2,[0])