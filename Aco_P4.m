clear all
close all
clc
%Generar seniales y vamos a aplicarles la transformada
%de Fourier y ver su comportamiento

%% Establecer frecuencia de muestreo
fs = 1000; 

%% Establecer frecuencia de las distintas seÃ±ales
F1 = 5; 
F2 = 10;
F3 = 17;
F4 = 23;

%% Vectores de tiempo
t = 1/fs:1/fs:2; %Vector tiempo que llega hasta 2
t2 = 1/fs:1/fs:8; % Vector de tiempo que llega hasta 8

%% Vector de Frecuencias de acuerdo al teorema de Nyquist. En el cual dice que la frecuencia de muestreo tiene que ser el doble de la mayor componente que quieras observar 
f = fs*(0:((fs*t(end))/2))/(fs*t(end));
f2 = fs*(0:((fs*t2(end))/2))/(fs*t2(end));

%% Creación de las señales sinusoidales
s1 = sin(2*pi*F1*t); %F1 = 5
s2 = sin(2*pi*F2*t); %F1 = 10
s3 = sin(2*pi*F3*t); %F1 = 17
s4 = sin(2*pi*F4*t); %F1 = 23

% Comprobación
figure('Name', 'Señales Sinusoidales', 'units',...
    'normalized', 'outerposition', [0 0 1 1])

subplot(4,1,1)
plot(t,s1)
title(['Señal Sinusoidal ',num2str(F1),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,1,2)
plot(t,s2)
title(['Señal Sinusoidal ',num2str(F2),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,1,3)
plot(t,s3)
title(['Señal Sinusoidal ',num2str(F3),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,1,4)
plot(t,s4)
title(['Señal Sinusoidal ',num2str(F4),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

%% Aplicar la transformada rápida de Fourier de Fourier
%para obtener sus componentes frecuenciales
Fourier1 = fft(s1);
Fourier2 = fft(s2);
Fourier3 = fft(s3);
Fourier4 = fft(s4);
% Tiene componentes reales e imaginarios, por lo que
% debemos aplicar el % valor absoluto

%% Aplicar valor absoluto y aplicar normalización
Mag1 = abs(Fourier1/(fs*t(end)));
Mag2 = abs(Fourier2/(fs*t(end)));
Mag3 = abs(Fourier3/(fs*t(end)));
Mag4 = abs(Fourier4/(fs*t(end)));

%Cuando se estudian señales reales, l espectro es
%simétrico, por lo que solo se puede graficar la mitad
%de los valores y evitar hacer el fftshift agregaremos
%una división entre el número de puntos para que los
%valores de las amplitudes vayan entre 0 y 1.

%% Se quiere acomodar las frecuencias para obtener una normalizaciÃ³n correcta y agarrar nomÃ¡s la mitad
Norm1 = Mag1(1:(fs*t(end))/2+1);
Norm1(2:end-1) = 2*Norm1(2:end-1);
Norm2 = Mag2(1:(fs*t(end))/2+1);
Norm2(2:end-1) = 2*Norm2(2:end-1);
Norm3 = Mag3(1:(fs*t(end))/2+1);
Norm3(2:end-1) = 2*Norm3(2:end-1);
Norm4 = Mag4(1:(fs*t(end))/2+1);
Norm4(2:end-1) = 2*Norm4(2:end-1);

%% Graficación de las figuras
figure('Name', 'Individual Fourier', 'units',...
    'normalized', 'outerposition', [0 0 1 1])

subplot(4,2,1)
plot(t,s1)
title(['Señal Sinusoidal de ',num2str(F1),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,3)
plot(t,s2)
title(['Señal Sinusoidal ',num2str(F2),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,5)
plot(t,s3)
title(['Señal Sinusoidal ',num2str(F3),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,7)
plot(t,s4)
title(['Señal Sinusoidal ',num2str(F4),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,2)
plot(f,Norm1)
axis([0 50 0 1])
title (['Espectro de Fourier Señal Sinusoidal de ',...
    num2str(F1),' Hz']);
xlabel('Frecuencia');

subplot(4,2,4)
plot(f,Norm2)
axis([0 50 0 1])
title (['Espectro de Fourier Señal Sinusoidal de ',num2str(F2),' Hz']);
xlabel('Frecuencia');

subplot(4,2,6)
plot(f,Norm3)
axis([0 50 0 1])
title (['Espectro de Fourier Señal Sinusoidal de ',num2str(F3),' Hz']);
xlabel('Frecuencia');

subplot(4,2,8)
plot(f,Norm4)
axis([0 50 0 1])
title (['Espectro de Fourier Señal Sinusoidal de ',num2str(F4),' Hz']);
xlabel('Frecuencia');

%% Operaciones con las señales
% Ya trabajamos la señales por separado, ahora se
% sumarán y concatenarán

% Señales Sumadas
SumSeniales = s1+s2+s3+s4;
% Señales Concatenadas
CatSeniales = [s1 s2 s3 s4];

figure('Name', 'Comparación de señales', 'units',...
    'normalized', 'outerposition', [0 0 1 1])
subplot(2,1,1)
plot(t,SumSeniales)
title('Suma de las señales');
xlabel('Tiempo (seg)')
ylabel('Amplitud')

subplot(2,1,2)
plot(t2,CatSeniales); %Se usa el vector de tiempo de 8 segundos ya que al concatenar las señales se hicieron 8 segundos en total
title('Concatenación de las señales');
xlabel('Tiempo (seg)')
ylabel('Amplitud')

% Espectro de Fourier de la señal sumada
FourierSum=fft(SumSeniales);

% Espectro de Fourier de la señal concatenada
FourierCat = fft(CatSeniales);

% Magnitud Espectral normalizada
MagSum = abs(FourierSum/(fs*t(end)));
MagCat = abs(FourierCat/(fs*t2(end)));

% Se acomodan las frecuencias
NormSum = MagSum(1:(fs*t(end))/2+1);
NormSum(2:end-1) = 2*NormSum(2:end-1);
NormCat = MagCat(1:(fs*t2(end))/2+1);
NormCat(2:end-1) = 2*NormCat(2:end-1);

% Graficación de los resultados
figure('Name', 'Suma-Concatenación', 'units', 'normalized',...
    'outerposition', [0 0 1 1])
subplot(2,2,1)
plot(t,SumSeniales)
title('Suma de las señales');
xlabel('Tiempo(seg)')
ylabel('Amplitud')

subplot(2,2,3)
plot(t2,CatSeniales)
title('Concatenación de las señales');
xlabel('Tiempo(seg)')
ylabel('Amplitud')

subplot(2,2,2)
plot(f,NormSum)
axis([0 50 0 1])
title('Espectro de Fourier de las señales sumadas')
xlabel('Frecuencia (Hz)')

subplot(2,2,4)
plot(f2,NormCat)
axis([0 50 0 1])
title('Espectro de Fourier señales concatenadas')
xlabel('Frecuencia (Hz)')

%% Señales Desfasadas
% Que pasaria si a las señales sinusoidales originales se les agrega un desfase

s5 = sin(2*pi*F1*t+pi/3); % Señal 1 desfasada pi/3
s6 = sin(2*pi*F2*t+pi/2); % Señal 2 desfasada pi/2
s7 = sin(2*pi*F3*t+pi/3); % Señal 3 desfasada pi/3
s8 = sin(2*pi*F4*t+pi); % Señal 4 desfasada pi

figure('Name', 'Señales y Desfase', 'units', 'normalized', 'outerposition', [0 0 1 1])

subplot(4,2,1)
plot(t,s1)
title(['Señal Sinusoidal de ',num2str(F1),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,3)
plot(t,s2)
title(['Señal Sinusoidal de ',num2str(F2),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,5)
plot(t,s3)
title(['Señal Sinusoidal de ',num2str(F3),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,7)
plot(t,s4)
title(['Señal Sinusoidal de ',num2str(F4),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,2)
plot(t,s5)
title(['Señal Sinusoidal de ',num2str(F1),' Hz con \phi=\pi/3']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,4)
plot(t,s6)
title(['Señal Sinusoidal de ',num2str(F2),' Hz con \phi=\pi/2']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,6)
plot(t,s7)
title(['Señal Sinusoidal de ',num2str(F3),' Hz con \phi=\pi/3']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,8)
plot(t,s8)
title(['Señal Sinusoidal de ',num2str(F4),' Hz con \phi=\pi']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

%% Aplicar la transformada rápida de Fourier para obtener sus componentes frecuenciales
Fourier5 = fft(s5);
Fourier6 = fft(s6);
Fourier7 = fft(s7);
Fourier8 = fft(s8);

% Tiene componentes reales e imaginarios, por lo que debemos aplicar el
% valor absoluto

%% Aplicar valor absoluto y aplicar normalización
Mag5 = abs(Fourier5/(fs*t(end)));
Mag6 = abs(Fourier6/(fs*t(end)));
Mag7 = abs(Fourier7/(fs*t(end)));
Mag8 = abs(Fourier8/(fs*t(end)));

%% Se acomodan las frecuencias para obtener la normalización correcta (medio espectro)
Norm5 = Mag5(1:(fs*t(end))/2+1);
Norm5(2:end-1) = 2*Norm5(2:end-1);
Norm6 = Mag6(1:(fs*t(end))/2+1);
Norm6(2:end-1) = 2*Norm6(2:end-1);
Norm7 = Mag7(1:(fs*t(end))/2+1);
Norm7(2:end-1) = 2*Norm7(2:end-1);
Norm8 = Mag8(1:(fs*t(end))/2+1);
Norm8(2:end-1) = 2*Norm8(2:end-1);

%% Graficación de las figuras
figure('Name', 'Fourier de las señales en fase y desfasadas', 'units', ...
    'normalized', 'outerposition', [0 0 1 1])

subplot(4,2,1)
plot(f,Norm1)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F1),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,3)
plot(f,Norm2)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F2),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,5)
plot(f,Norm3)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F3),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,7)
plot(f,Norm4)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F4),' Hz']);
xlabel('Tiempo (seg)');
ylabel('Amplitud');

subplot(4,2,2)
plot(f,Norm5)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F1),' Hz con \phi=\pi/3']);
xlabel('Frecuencia');
ylabel('Amplitud');

subplot(4,2,4)
plot(f,Norm6)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F2),' Hz con \phi=\pi/2']);
xlabel('Frecuencia');
ylabel('Amplitud');

subplot(4,2,6)
plot(f,Norm7)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F3),' Hz con \phi=\pi/3']);
xlabel('Frecuencia');
ylabel('Amplitud');

subplot(4,2,8)
plot(f,Norm8)
axis([0 50 0 1])
title(['Espectro de Fourier de la señal de ',num2str(F4),' Hz con \phi=\pi']);
xlabel('Frecuencia');
ylabel('Amplitud');

%Como vimos, el espectro de Fourier con o sin desfase tiene los mismo
%componentes frecuenciales, pero sabemos que la señal no es igual, por lo
%que se debe obtener la fase de la señal de Fourier. Introducimos el
%vector entre la frecuencia de muestreo por el tiempo final. Por lo que
%obtenemos la magnitud

%% Función Angle para sacar la fase de la señal de Fourier
MagAng1 = angle(Fourier1/(fs*t(end)));
MagAng2 = angle(Fourier2/(fs*t(end)));
MagAng3 = angle(Fourier3/(fs*t(end)));
MagAng4 = angle(Fourier4/(fs*t(end)));
MagAng5 = angle(Fourier5/(fs*t(end)));
MagAng6 = angle(Fourier6/(fs*t(end)));
MagAng7 = angle(Fourier7/(fs*t(end)));
MagAng8 = angle(Fourier8/(fs*t(end)));

NormAng1 = MagAng1(1:(fs*t(end))/2+1);
NormAng2 = MagAng2(1:(fs*t(end))/2+1);
NormAng3 = MagAng3(1:(fs*t(end))/2+1);
NormAng4 = MagAng4(1:(fs*t(end))/2+1);
NormAng5 = MagAng5(1:(fs*t(end))/2+1);
NormAng6 = MagAng6(1:(fs*t(end))/2+1);
NormAng7 = MagAng7(1:(fs*t(end))/2+1);
NormAng8 = MagAng8(1:(fs*t(end))/2+1);

%% Graficamos
figure('Name','Fase de Fourier', 'units', 'normalized', 'outerposition', [0 0 1 1])
subplot(4,2,1)
plot(f, NormAng1)
title('Espectro de Fourier')
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
xlabel('f')

subplot(4,2,3)
plot(f, NormAng2)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')

subplot(4,2,5)
plot(f, NormAng3)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')

subplot(4,2,7)
plot(f, NormAng4)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')

subplot(4,2,2)
plot(f, NormAng5)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')

subplot(4,2,4)
plot(f, NormAng6)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')

subplot(4,2,6)
plot(f, NormAng7)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')

subplot(4,2,8)
plot(f, NormAng8)
axis([0 50 -1 1])
set(gca, 'YTickLabel', {'2\pi' '0' '-2\pi'})
title('Espectro de Fourier')
xlabel('f')