function varargout = Practica5(varargin)
%PRACTICA5 MATLAB code file for Practica5.fig
%      PRACTICA5, by itself, creates a new PRACTICA5 or raises the existing
%      singleton*.
%
%      H = PRACTICA5 returns the handle to a new PRACTICA5 or the handle to
%      the existing singleton*.
%
%      PRACTICA5('Property','Value',...) creates a new PRACTICA5 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Practica5_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PRACTICA5('CALLBACK') and PRACTICA5('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PRACTICA5.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Practica5

% Last Modified by GUIDE v2.5 20-Feb-2023 21:48:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Practica5_OpeningFcn, ...
                   'gui_OutputFcn',  @Practica5_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Practica5 is made visible.
function Practica5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Practica5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Practica5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Practica5_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when btg1 is resized.
function btg1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to btg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in btg1.
function btg1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in btg1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fs = get (handles.frec,'string');
    fs = round(str2double(fs));
    
    %FS = eval (fs);
    
    am = get (handles.amp,'string');
    am = round(str2double(am));
    % AM = eval (am);
    fn = 500;
    T = 2;

    % selectedButton = get(handles.btg1, 'SelectedButton');
    
    selectedRadioButton(fs, am, handles);

function amp_Callback(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp as text
%        str2double(get(hObject,'String')) returns contents of amp as a double



ampli  = get(hObject,'string');
ampli = str2double(ampli);
ampli = round (ampli);
set (hObject,'string',num2str(ampli));

% --- Executes during object creation, after setting all properties.
function amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min1_Callback(hObject, eventdata, handles)
% hObject    handle to min1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min1 as text
%        str2double(get(hObject,'String')) returns contents of min1 as a double


% --- Executes during object creation, after setting all properties.
function min1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
frecu = get (hObject, 'Value');

frecu = round (frecu);

t = 0:0.1:50;

set (handles.frec,'string',num2str(frecu));
% set(slider, 'Callback', @slider_callback);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    am = get (handles.amp,'string');
    am = round(str2double(am));
    % AM = eval (am);
    %selectedButton = get (handles.btg1, 'SelectedObject');
    
    selectedRadioButton(frecu, am, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %y = sin(t * frecu/100);
    %plot(handles.axes1, t, y);

minf = get (hObject,'Min');
minf = round (minf);
set (handles.min1,'string',num2str(minf));

maxf = get (hObject,'Max');
maxf = round (maxf);
set (handles.max1,'string',num2str(maxf));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function frec_Callback(hObject, eventdata, handles)
% hObject    handle to frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frec as text
%        str2double(get(hObject,'String')) returns contents of frec as a double


% --- Executes during object creation, after setting all properties.
function frec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max1_Callback(hObject, eventdata, handles)
% hObject    handle to max1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max1 as text
%        str2double(get(hObject,'String')) returns contents of max1 as a double


% --- Executes during object creation, after setting all properties.
function max1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function selectedRadioButton(fs, am, handles)

    fn = 500;
    T = 2;
    
if get(handles.seno, 'Value') == 1
    % graficar senoidal

    % handles.FS1 = FS
    % handles.AM1 = AM

    t = 0:1/fn:T;
    SenalSeno = am * sin (2 * pi * fs * t);
    plot (handles.axes1,t,SenalSeno)%
   

elseif get(handles.cose, 'Value') == 1

    % handles.FS1 = FS
    % handles.AM1 = AM

    t = 0:1/fn:T;
    SenalCos = am * cos (2 * pi * fs * t);
    plot (handles.axes1,t,SenalCos)

elseif  get(handles.cua, 'Value') == 1
    
    %handles.FS1 = FS
    %handles.AM1 = AM

    t = 0:1/fn:T;
    
    SenalCuadrada = am * square (2 * pi * fs * t);
    plot (handles.axes1,t,SenalCuadrada)
    
elseif get(handles.ds, 'Value') == 1

    %handles.FS1 = FS
    %handles.AM1 = AM

    t = 0:1/fn:T;
    
    SenalDiSi = am * sawtooth (2 * pi * fs * t);
    plot (handles.axes1,t,SenalDiSi)
end

