function varargout = USview(varargin)
% USVIEW M-file for USview.fig
%      USVIEW, by itself, creates a new USVIEW or raises the existing
%      singleton*.
%
%      H = USVIEW returns the handle to a new USVIEW or the handle to
%      the existing singleton*.
%
%      USVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USVIEW.M with the given input arguments.
%
%      USVIEW('Property','Value',...) creates a new USVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before USview_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to USview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help USview

% Last Modified by GUIDE v2.5 26-Aug-2010 10:18:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @USview_OpeningFcn, ...
                   'gui_OutputFcn',  @USview_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
global a
%a = varargin;

% --- Executes just before USview is made visible.
function USview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to USview (see VARARGIN)
fnoise = fopen(varargin{1},'r');
handles.data = fread (fnoise,'float32');
handles.data = handles.data-mean(handles.data);
si = (1/195312.2);
handles.taxis=(si:si:(length(handles.data)*si));
handles.sf = 0.1;
rangestart = 1;
rangeend = floor(1+handles.sf*length(handles.data));
axes(handles.axes1);
spectrogram(handles.data(rangestart:rangeend),512,256,512,195312.5,'yaxis');
set(handles.axes1,'YTick',[0;10000;20000;30000;40000;50000;60000;70000;80000;90000;100000]);
set(handles.axes1,'YTickLabel',[0;10;20;30;40;50;60;70;80;90;100]);
ylabel('Frequency(kHz)');
set(handles.axes1,'TickDir','out');
set(handles.axes1,'XAxisLocation','top');
xlabel('Time(s)');
colormap(hot);
axes(handles.axes4);
plot(handles.taxis(rangestart:rangeend),handles.data(rangestart:rangeend));
xlim([handles.taxis(rangestart) handles.taxis(rangeend)]);
ylim([-5*std(handles.data) 5*std(handles.data)]);

% Choose default command line output for USview
handles.output = hObject;
%get(handles.output,'Children')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes USview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = USview_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
slidpos = get(hObject,'Value');
rangestart = ceil(slidpos*length(handles.data))+1;
rangeend = floor(rangestart+(handles.sf*length(handles.data)));
if rangeend > length(handles.data)
    rangeend = floor(slidpos*length(handles.data));
    rangestart = floor(rangeend-(handles.sf*length(handles.data)));
end
%handles.specsf = handles.sf./0.10;
%specsf=handles.specsf/4;
axes(handles.axes1);
if handles.sf > 0.0125
    spectrogram(handles.data(rangestart:rangeend),512,256,512,195312.5,'yaxis');
end
if handles.sf > 0.00624 & handles.sf < 0.0126
    spectrogram(handles.data(rangestart:rangeend),1024,940,1024,195312.5,'yaxis');
end
if handles.sf < 0.00624
    spectrogram(handles.data(rangestart:rangeend),1024,768,1024,195312.5,'yaxis');
end
set(handles.axes1,'YTick',[0;10000;20000;30000;40000;50000;60000;70000;80000;90000;100000]);
set(handles.axes1,'YTickLabel',[0;10;20;30;40;50;60;70;80;90;100]);
YLabel('Frequency(kHz)');
set(handles.axes1,'TickDir','out');
set(handles.axes1,'XAxisLocation','top');
XLabel('Time(s)');
colormap(hot);
axes(handles.axes4);
plot(handles.taxis(rangestart:rangeend),handles.data(rangestart:rangeend))
XLim([handles.taxis(rangestart) handles.taxis(rangeend)])
YLim([-5*std(handles.data) 5*std(handles.data)]);
guidata(hObject, handles);


% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
%if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
   % set(hObject,'BackgroundColor',[0.8 0.8 0.8]);
%end




% --- Executes on button press in zoomin.
function zoomin_Callback(hObject, eventdata, handles)
handles.sf = handles.sf./2;
currslidstep = get(handles.slider1,'SliderStep');
set(handles.slider1,'SliderStep',currslidstep./2);
guidata(hObject, handles);
slidpos = get(hObject,'Value');
rangestart = ceil(slidpos*length(handles.data))+1;
rangeend = floor(rangestart+(handles.sf*length(handles.data)));
if rangeend > length(handles.data)
    rangeend = floor(slidpos*length(handles.data));
    rangestart = floor(rangeend-(handles.sf*length(handles.data)));
end
handles.specsf = handles.sf./0.10;
specsf=handles.specsf;
axes(handles.axes1);
if handles.sf > 0.0125
    spectrogram(handles.data(rangestart:rangeend),512,256,512,195312.5,'yaxis');
end
if handles.sf > 0.00624 & handles.sf < 0.0126
    spectrogram(handles.data(rangestart:rangeend),1024,940,1024,195312.5,'yaxis');
end
if handles.sf < 0.00624
    spectrogram(handles.data(rangestart:rangeend),1024,768,1024,195312.5,'yaxis');
end
set(handles.axes1,'YTick',[0;10000;20000;30000;40000;50000;60000;70000;80000;90000;100000]);
set(handles.axes1,'YTickLabel',[0;10;20;30;40;50;60;70;80;90;100]);
YLabel('Frequency(kHz)');
set(handles.axes1,'TickDir','out');
set(handles.axes1,'XAxisLocation','top');
XLabel('Time(s)');
colormap(hot);
axes(handles.axes4);
plot(handles.taxis(rangestart:rangeend),handles.data(rangestart:rangeend))
XLim([handles.taxis(rangestart) handles.taxis(rangeend)])
YLim([-5*std(handles.data) 5*std(handles.data)]);
guidata(hObject, handles);
% hObject    handle to zoomin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zoomout.
function zoomout_Callback(hObject, eventdata, handles)
if handles.sf > 0.5;
    handles.sf = 1;
else
    handles.sf = handles.sf*2;
end
currslidstep = get(handles.slider1,'SliderStep');
set(handles.slider1,'SliderStep',currslidstep*2);
guidata(hObject, handles);
slidpos = get(hObject,'Value');
rangestart = ceil(slidpos*length(handles.data))+1;
rangeend = floor(rangestart+(handles.sf*length(handles.data)));
if rangeend > length(handles.data)
    rangeend = floor(slidpos*length(handles.data));
    rangestart = floor(rangeend-(handles.sf*length(handles.data)));
end
handles.specsf = handles.sf./0.10;
specsf=handles.specsf;
axes(handles.axes1);

if handles.sf > 0.0125
    spectrogram(handles.data(rangestart:rangeend),512,256,512,195312.5,'yaxis');
end
if handles.sf > 0.00624 & handles.sf < 0.0126
    spectrogram(handles.data(rangestart:rangeend),1024,940,1024,195312.5,'yaxis');
end
if handles.sf < 0.00624
    spectrogram(handles.data(rangestart:rangeend),1024,768,1024,195312.5,'yaxis');
end

set(handles.axes1,'YTick',[0;10000;20000;30000;40000;50000;60000;70000;80000;90000;100000]);
set(handles.axes1,'YTickLabel',[0;10;20;30;40;50;60;70;80;90;100]);
YLabel('Frequency(kHz)');
set(handles.axes1,'TickDir','out');
set(handles.axes1,'XAxisLocation','top');
XLabel('Time(s)');
colormap(hot);
axes(handles.axes4);
plot(handles.taxis(rangestart:rangeend),handles.data(rangestart:rangeend))
XLim([handles.taxis(rangestart) handles.taxis(rangeend)])
YLim([-5*std(handles.data) 5*std(handles.data)]);
guidata(hObject, handles);
% hObject    handle to zoomout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


