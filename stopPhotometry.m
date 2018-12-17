function stopPhotometry
    global state
    global vid
    global olf_port
    delete(olf_port);
    warning('you should update code to wait for last refresh period to elapse');
        state.photometry.session.stop;
        state.photometry2.session2.stop;
        state.mic.session.stop;
        stop(vid);
        %odorSeq=state.olf.odorSeq;
        save(fullfile(state.photometry.savePath, state.photometry.saveName),'state');
        state.photometry.session.outputSingleScan(zeros(1, (sum(state.photometry.channelsOn<=2)))); % make sure LEDs are turned off