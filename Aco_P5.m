%%ANALISIS TEMPORAL DE SEÑALES SIMULADAS

%%Código de creación de las señales
fs=200;
t=[1/fs:1/fs:4];
t2=[1/fs:1/fs:24];
f=fs*(0:((fs*t(end))/2))/(fs*t(end));
f2=fs*(0:((fs*t2(end))/2))/(fs*t2(end));

%frecuencias de las señales
f_senial1=3;
f_senial2=7;
f_senial3=12;
f_senial4=25;
f_senial5=32;
f_senial6=49;






%Generación de las señales
s1=sin(2*pi*f_senial1*t);
s2=cos(2*pi*f_senial2*t);
s3=sin(2*pi*f_senial3*t);
s4=cos(2*pi*f_senial4*t);
s5=sin(2*pi*f_senial5*t);
s6=cos(2*pi*f_senial6*t);


%%graficacion de las señales
figure(1)
subplot(3,2,1);
plot(t,s1);
title('Señal 1(3Hz)');
xlabel('Tiempo(s)');
subplot(3,2,2);
plot(t,s2);
title('Señal 2(7Hz)');
xlabel('Tiempo(s)');
subplot(3,2,3)
plot(t,s3);
title('Señal 3(12Hz)');
xlabel('Tiempo(s)');
subplot(3,2,4)
plot(t,s4);
title('Señal 4(25Hz)');
xlabel('Tiempo(s)');
subplot(3,2,5)
plot(t,s5);
title('Señal 5(32Hz)');
xlabel('Tiempo(s)');
subplot(3,2,6)
plot(t,s6);
title('Señal 6(49Hz)');
xlabel('Tiempo(s)');







%concatenacion y sumatoria de las señales
s7=[s1,s2,s3,s4,s5,s6];
s8=s1+s2+s3+s4+s5+s6;
figure(2)
plot(t2,s7);
title('Señal Concatenada')
xlabel('Tiempo(s)');
figure(3)
plot(t,s8);
title('Señal Sumada')
xlabel('Tiempo(s)')


%--------------------------------------------------------------------------
%ANALISIS FRECUENCIAL DE LAS SEÑALES SIMULADAS

Fourier7=fft(s7);
Fourier8=fft(s8);
Mag7=abs(Fourier7/(fs*t2(end)));
Mag8=abs(Fourier8/(fs*t(end)));
Norm7=Mag7(1:(fs*t2(end))/2+1);
Norm7(2:end-1)=2*Norm7(2:end-1);
Norm8=Mag8(1:(fs*t(end))/2+1);
Norm8(2:end-1)=2*Norm8(2:end-1);


figure(4)
plot(t2,s7);
title('Señal Concatenada')
xlabel('Tiempo(s)');
figure(5)
plot(t,s8);
title('Señal Sumada')
xlabel('Tiempo(s)');





%Ultima señal
f_senial1=3;
f_senial2=7;
f_senial3=19;
f_senial4=28;
f_senial5=37;
f_senial6=45;
f_senial9=67;
f_senial10=77;
f_senial11=85;
f_senial12=90;
f_senial13=57;
f_senial14=40;
s1=sin(2*pi*f_senial1*t);
s2=cos(2*pi*f_senial2*t);
s3=sin(2*pi*f_senial3*t);
s4=cos(2*pi*f_senial4*t);
s5=sin(2*pi*f_senial5*t);
s6=sin(2*pi*f_senial6*t);
s9=sin(2*pi*f_senial9*t);
s10=sin(2*pi*f_senial10*t);
s11=cos(2*pi*f_senial11*t);
s12=sin(2*pi*f_senial12*t);
s13=cos(2*pi*f_senial13*t);
s14=cos(2*pi*f_senial14*t);


S15=s1+s2+s3+s4+s5+s6+s9+s10+s11+s12+s13+s14;%SEÑAL CON 12 FREC
Fourier15=fft(S15);
Mag15=abs(Fourier15/(fs*t(end)));
Norm15=Mag15(1:(fs*t(end))/2+1);
Norm15(2:end-1)=2*Norm15(2:end-1);


figure(6)%Graficas de la señal con las 12 frec
subplot(1,2,1)
plot(t,S15)
title('Señal con 12 frecuencias');
xlabel('Tiempo(s)');
subplot(1,2,2)
plot(f,Norm15);
axis([0 100 0 1])
title('Fourier Spectrum')
xlabel('f')







