function varargout = PhotometryMainGUI(varargin)
% PHOTOMETRYMAINGUI MATLAB code for PhotometryMainGUI.fig
%      PHOTOMETRYMAINGUI, by itself, creates a new PHOTOMETRYMAINGUI or raises the existing
%      singleton*.
%
%      H = PHOTOMETRYMAINGUI returns the handle to a new PHOTOMETRYMAINGUI or the handle to
%      the existing singleton*.
%
%      PHOTOMETRYMAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHOTOMETRYMAINGUI.M with the given input arguments.
%
%      PHOTOMETRYMAINGUI('Property','Value',...) creates a new PHOTOMETRYMAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PhotometryMainGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PhotometryMainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PhotometryMainGUI

% Last Modified by GUIDE v2.5 07-Aug-2018 15:10:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PhotometryMainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PhotometryMainGUI_OutputFcn, ...
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


% --- Executes just before PhotometryMainGUI is made visible.
function PhotometryMainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PhotometryMainGUI (see VARARGIN)

% Choose default command line output for PhotometryMainGUI
handles.output = hObject;

% create the listener for the slider
%  handles.sliderListener = addlistener(handles.Ch1AmpSlider,'ContinuousValueChange',@(hFigure,eventdata) Ch1AmpSliderContValCallback(hObject,eventdata));
%  handles.sliderListener = addlistener(handles.Ch2AmpSlider,'ContinuousValueChange',@(hFigure,eventdata) Ch2AmpSliderContValCallback(hObject,eventdata));
 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PhotometryMainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PhotometryMainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% FS-  callback to set save path
    global state
    
    [fname, pname] = uiputfile('path', 'Choose save path'); % outputs 0 if user cancels
    if pname == 0 % if user canceled
        return
    else
        state.photometry.savePath = pname;
        updateGUIByGlobal('state.photometry.savePath');
    end



function savePath_Callback(hObject, eventdata, handles)
% hObject    handle to savePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savePath as text
%        str2double(get(hObject,'String')) returns contents of savePath as a double
    genericCallback(hObject);



% --- Executes during object creation, after setting all properties.
function savePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
startPhotometry; 


% --- Executes on slider movement.
function Ch1AmpSlider_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1AmpSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    genericCallback(hObject);
    updateGUIByGlobal('state.photometry.channel1Amp');
    
% --- Executes during object creation, after setting all properties.
function Ch1AmpSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1AmpSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stopPhotometry;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initPhotometry;
Video;



% --- Executes on slider movement.
function Ch2AmpSlider_Callback(hObject, eventdata, handles)
% hObject    handle to Ch2AmpSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    genericCallback(hObject);
    updateGUIByGlobal('state.photometry.channel2Amp');

% --- Executes during object creation, after setting all properties.
function Ch2AmpSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch2AmpSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end









%function Ch1AmpText_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1AmpText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch1AmpText as text
%        str2double(get(hObject,'String')) returns contents of Ch1AmpText as a double



function baseName_Callback(hObject, eventdata, handles)
% hObject    handle to baseName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of baseName as text
%        str2double(get(hObject,'String')) returns contents of baseName as a double
    genericCallback(hObject);
    setSaveName;

% --- Executes during object creation, after setting all properties.
function baseName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baseName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saveName_Callback(hObject, eventdata, handles)
% hObject    handle to saveName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saveName as text
%        str2double(get(hObject,'String')) returns contents of saveName as a double


% --- Executes during object creation, after setting all properties.
function saveName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saveName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sessionNumber_Callback(hObject, eventdata, handles)
% hObject    handle to sessionNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionNumber as text
%        str2double(get(hObject,'String')) returns contents of sessionNumber as a double
    genericCallback(hObject);
    setSaveName;
    


% --- Executes during object creation, after setting all properties.
function sessionNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channel1Amp_Callback(hObject, eventdata, handles)
% hObject    handle to channel1Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel1Amp as text
%        str2double(get(hObject,'String')) returns contents of channel1Amp as a double


% --- Executes during object creation, after setting all properties.
function channel1Amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel1Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channel2Amp_Callback(hObject, eventdata, handles)
% hObject    handle to channel2Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel2Amp as text
%        str2double(get(hObject,'String')) returns contents of channel2Amp as a double


% --- Executes during object creation, after setting all properties.
function channel2Amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel2Amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in channel1On.
function channel1On_Callback(hObject, eventdata, handles)
% hObject    handle to channel1On (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel1On
    genericCallback(hObject);


% --- Executes on button press in channel2On.
function channel2On_Callback(hObject, eventdata, handles)
% hObject    handle to channel2On (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of channel2On
    genericCallback(hObject);


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

val=get(hObject,'Value');

if val==1
    pre_vid = videoinput('winvideo', 1);
    preview(pre_vid);
else
    closepreview;
    clear pre_vid;
end
