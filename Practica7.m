function varargout = Practica7(varargin)
% PRACTICA7 MATLAB code for Practica7.fig
%      PRACTICA7, by itself, creates a new PRACTICA7 or raises the existing
%      singleton*.
%
%      H = PRACTICA7 returns the handle to a new PRACTICA7 or the handle to
%      the existing singleton*.
%
%      PRACTICA7('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRACTICA7.M with the given input arguments.
%
%      PRACTICA7('Property','Value',...) creates a new PRACTICA7 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Practica7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Practica7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Practica7

% Last Modified by GUIDE v2.5 04-May-2023 22:00:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Practica7_OpeningFcn, ...
                   'gui_OutputFcn',  @Practica7_OutputFcn, ...
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


% --- Executes just before Practica7 is made visible.
function Practica7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Practica7 (see VARARGIN)

% Choose default command line output for Practica7
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Practica7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Practica7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

fs=1000;
F1=5
t = 1/fs:1/fs:2; %Vector tiempo que llega hasta 2
t2 = 1/fs:1/fs:8; % Vector de tiempo que llega hasta 8
f = fs*(0:((fs*t(end))/2))/(fs*t(end));
f2 = fs*(0:((fs*t2(end))/2))/(fs*t2(end));
s1= square(2*pi*F1*t); %f1=5


title('Señal cuadratica ');
xlabel('Tiempo (seg)');
ylabel('Amplitud');
plot (handles.SenalOriginal,t,s1)

%aplicar transformada rapida de fourier
Fourier1 = fft(s1);

% Aplicar valor absoluto y aplicar normalización
Mag1 = abs(Fourier1/(fs*t(end)));

%acomodar las frecuencias para obtener una normalizaciÃ³n correcta y agarrar nomÃ¡s la mitad
Norm1 = Mag1(1:(fs*t(end))/2+1);
Norm1(2:end-1) = 2*Norm1(2:end-1);

title('Señal con fourier ');
xlabel('Tiempo (seg)');
ylabel('Amplitud');
plot (handles.Fourier,t,s1)


 




varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
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
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
