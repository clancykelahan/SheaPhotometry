function varargout = pulseMaker(varargin)
% PULSEMAKER Application M-file for pulseMaker.fig
%    FIG = PULSEMAKER launch pulseMaker GUI.
%    PULSEMAKER('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 27-Sep-2012 16:04:01

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
		end
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.





% --------------------------------------------------------------------
function varargout = changePulse_Callback(h, eventdata, handles, varargin)
	genericCallback(h);
	global state
	tag=get(h, 'Tag');
	if ~isempty(findstr('Slider', tag))
		tag=tag(1:end-6);
	end
	if eval(['ischar(state.phys.pulses.' tag ')'])
		eval(['state.phys.pulses.' tag 'List{state.phys.pulses.patternNumber} = state.phys.pulses.' tag ';']);
	else
		eval(['state.phys.pulses.' tag 'List(state.phys.pulses.patternNumber) = state.phys.pulses.' tag ';']);
	end
	makePulsePattern;
	
	if any(state.phys.pulses.patternNumber == [...
				state.cycle.da0List(state.cycle.currentCyclePosition) ...
				state.cycle.pulseToUse0 ...
				state.cycle.da1List(state.cycle.currentCyclePosition) ...
				state.cycle.aux4List(state.cycle.currentCyclePosition) ...
				state.cycle.aux5List(state.cycle.currentCyclePosition) ...
				state.cycle.aux6List(state.cycle.currentCyclePosition) ...
				state.cycle.aux7List(state.cycle.currentCyclePosition) ...
			])
		state.phys.internal.needNewOutputData=1;		% force update of output
	end
	
	try
		if state.blaster.active & ...
				any(state.blaster.allConfigs{state.blaster.currentConfig, 2}(:, 2) == state.phys.pulses.patternNumber)
			state.internal.needNewPcellRepeatedOutput=1;
			state.internal.needNewRepeatedMirrorOutput=1;
		end
	end
			
		
	if state.phys.settings.autoSavePatterns
		savePulseSet;
	end
	
	
% --------------------------------------------------------------------
function varargout = patternNumber_Callback(h, eventdata, handles, varargin)
	genericCallback(h);
	changePulsePatternNumber;


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
