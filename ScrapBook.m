% scrapBook
    if size(state.photometry.channelData, 1) >=  30 * state.photometry.sample_rate
        state.photometry.session.stop;
        ensureFigure('test', 1); plot((0:size(state.photometry.channelData, 1) - 1)' / state.photometry.sample_rate, state.photometry.channelData);
        disp('done');
    end