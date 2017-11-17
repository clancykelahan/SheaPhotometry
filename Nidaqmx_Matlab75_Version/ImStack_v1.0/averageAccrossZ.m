function averageAccrossZ
% This will take the average accross all the Z planes in an image or ROI.

global gh state

value = get(gh.imageProcessingGUI.fileName, 'Value');
[x,x1,y,y1] = getCurrentAxisLimits(state.imageProc.internal.axis{value});
state.imageProc.internal.averageImage=collapse(state.imageProc.currentImage(y:y1,x:x1,...
	state.imageProc.currentFrame:state.imageProc.numberOfFrames),'XY','average');
loadImageFromArray('state.imageProc.internal.averageImage');
