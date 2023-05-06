clc; clear all; close all;
fs = 200; %frecuencia de muestreo
T = 6; %Tiempo de muestreo
t = 0:1/fs:T-1/fs; %duracion
figure;
% Señal 1 - Seno
ss = 3 * sin( 2* pi * 5 * t);
subplot(2 , 1 , 1);
plot( t , ss , 'b');
title (' Seno ' );
ylabel ( 'Amplitud') ; xlabel (' Tiempo ' ) ;
% Señal 2 - Coseno
sc = 5 * cos( 2* pi * 3 * t);
subplot(2 , 1 , 2);
plot( t , sc , 'g' );
title (' Coseno ' );
ylabel ( 'Amplitud') ; xlabel (' Tiempo ' ) ;

figure;
%Distribuicion de las señales
subplot(2 , 2 , 1);

%S representa la matriz con las señales observadas
%A contiene los coeficientes de mezcla
%X simboliza las señales mezcla
plot( ss , sc , '.b' );
ylabel ( 'Señal 2') ; xlabel (' Señal 1' ) ;
S = [ss ; sc ];
A = [ .5 -.3 ; .3 -.8 ] ;
X = A * S ;

%Obtención de las señales individuales de la matriz X
X1 = X ( 1, : );
X2 = X ( 2, : );

subplot(2 , 2 , 2);
plot( X1 , X2 , '.r' ); %Gráfico de la distribución de las señales mezcla
ylabel ( ' X1 ') ; xlabel (' X2 ' ) ;

%Proceso de obtención de la matriz W.
%W representa la matriz de blanqueamiento
%Z contiene las señales blanqueadas
Rx = cov(X');
[V, D ] = eig(Rx) ;
W = D ^(-0.5) * V';
Z = W * X ;

%Obtención de las señales individuales de la matriz Z
Z1 = Z ( 1, : );
Z2 = Z ( 2, : );
subplot(2 , 2 , 3);
plot( Z1 , Z2 , '.g' ); %Gráfico de la distribución de las señales blanqueadas
ylabel ( ' Z1 ') ; xlabel (' Z2 ' ) ;

%Por medio de la función fastica se obtiene la matriz AA, matriz de mezcla estimada
%Proceso de obtención de la matriz Y, donde Y contiene las señales estimadas
[AA , B ] = fastica( X );
Y = inv(AA) * X;
Y1 = Y ( 1, : ); %Obtención de las señales individuales de la matriz Y
Y2 = Y ( 2, : );
subplot(2 , 2 , 4);
plot( Y1 , Y2 , '.k' ); %Gráfico de la distribución de las señales estimadas

%SEPARACIÓN
figure;
Y1 = Y ( 1, : ); %Obtención de señales individuales de la matriz Y
Y2 = Y ( 2, : );

% Señal Estimada 1
subplot(2 , 1 , 1);
plot( t , Y1 , 'b');
title (' Senal Estimada 1 ' );
ylabel ( 'Amplitud') ;
xlabel (' Tiempo ' ) ;
% Señal Estimada 2
subplot(2 , 1 , 2);
plot( t , Y2 , 'g' ); %Se grafica individualmente cada señal estimada obtenida
title (' Señal Estimada 2 ' );
ylabel ( 'Amplitud') ;
xlabel (' Tiempo ' ) ;
 