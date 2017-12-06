function setSaveName

    global state
    t = datetime('today');
    year = t.Year;
%     year = year(3:4);
    day = t.Day;
    month = t.Month;
    todayS = sprintf('%04u%02u%02u', year, day, month);
    state.photometry.saveName = [state.photometry.baseName '_' todayS '_' sprintf('%02u', state.photometry.sessionNumber) '.mat'];
    updateGUIByGlobal('state.photometry.saveName');
    warning('** Make sure you are not overwriting old data, is session number unique?**');