function stopPhotometry
    global state
    global vid
    warning('you should update code to wait for last refresh period to elapse');
        state.photometry.session.stop;
        stop(vid)
        state.photometry.session.outputSingleScan(zeros(1, length(state.photometry.channelsOn))); % make sure LEDs are turned off