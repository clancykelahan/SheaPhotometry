function startPhotometry
    global state
    if isempty(state.photometry.saveName)
        return
    end
    warning('you need to add functoinality to add settings to saved data, see how bpod does this');
    state.photometry.session.startBackground; % start the recording