function stopPhotometry
    global state
    global vid
    warning('you should update code to wait for last refresh period to elapse');
        state.photometry.session.stop;
        state.photometry2.session2.stop;
        stop(vid);
        state.photometry.session.outputSingleScan(zeros(1, (sum(state.photometry.channelsOn<=2)))); % make sure LEDs are turned off