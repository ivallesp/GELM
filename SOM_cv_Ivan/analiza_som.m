%% Analiza los SOM obtenidos mediante entrena_som.m
% Se guardan los dos errores; el de cuantizaci�n da idea de lo bien que
% representa a los datos y el topogr�fico da idea de si se mantienen las
% relaciones de vecindad 

clear
clc
close all
load datosSOM;

% N�mero de SOM guardados en la carpeta ./maps
N=4008;
err_top=zeros(1,N);
err_qe=err_top;

for R=1:N,
    fileName=['./maps/som_' num2str(R)];
    feval('load', fileName); % Se carga el SOM
    [qe,te] = som_quality(sM,sD); % Calcula Error tipogr�fico y de cuantizaci�n
    err_top(R)=te; % Acumula errores topogr�ficos
    err_qe(R)=qe; % Acumula errores de cuantizaci�n
    R;
end

save errores err_top err_qe %Guarda los resultados
