

state.photometry.displayFigure = figure;
state.photometry.displayAxis = axes('Parent', state.photometry.displayFigure);
state.photometry.displayLineCh1 = line([NaN], 'Parent', state.photometry.displayAxis);
state.photometry.displayLineCh2 = line([NaN], 'Parent', state.photometry.displayAxis);




%% callback, replace the ydata
state.photometry.displayLineCh1.YData = newDataVariable;