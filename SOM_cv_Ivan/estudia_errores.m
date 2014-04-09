%% Estudiamos el error cometido en los mapas
% Ejecutar despu�s de ana�iza_som.m
% Para que queden ajustados los gr�ficos, una vez representados, mover la
% leyenda.

clear
close all
clc

load errores
err_qe=abs(err_qe); %Elimina parte imaginaria (Siempre vale 0)
%% C�lculo de errores escalados [0,1]
err_qe_scaled=(err_qe-min(err_qe))/max((err_qe-min(err_qe)));
err_top_scaled=(err_top-min(err_top))/max((err_top-min(err_top)));
%% CRITERIO 1: Error cuantizacion m�nimo cuando topogr�fico=0
topcero=find(err_top==0);
[valor,aux]=min(err_qe(topcero));
indice=topcero(aux);
clear aux

%% CRITERIO 2: min(Error de cuantizaci�n (S) + Error topogr�fico (S))
[aux,indice(2)]=min(err_qe_scaled+err_top_scaled);

%% CRITERIO 3: min((Error de cuantizaci�n (S) + 1) * (Error topogr�fico (S) + 1))
[aux,indice(3)]=min((err_qe_scaled+1).*(err_top_scaled+1));

%% CRITERIO 4: m�nima distancia eucl�dea al pto. [0,0] y [err_qe_scaled,err_top_scaled]
for i=1:length(err_qe)
    distancia_a_0(i)=distance(err_qe_scaled(i),err_top_scaled(i),0,0);
end
[aux,indice(4)]=min(distancia_a_0);

%% REPRESENTACI�N GR�FICA
figure()

subplot(2,2,1)
    boxplot(err_qe);
    title('Error de cuantizaci�n')
    grid
    hold on
    plot(xlim,[err_qe(indice(1)),err_qe(indice(1))],'c--','linewidth',2)
    plot(xlim,[err_qe(indice(2)),err_qe(indice(2))],'r--','linewidth',2)
    plot(xlim,[err_qe(indice(3)),err_qe(indice(3))],'b--','linewidth',2)
    plot(xlim,[err_qe(indice(4)),err_qe(indice(4))],'m--','linewidth',2)
    hold off
    legend('min(err\_qe(err\_top==0))','min(err\_top+err_qe)', 'min((err\_top+1).*(err\_qe+1))','Distancia a 0','Location','SouthOutside');
subplot(2,2,3)
    boxplot(err_top);
    title('Error topogr�fico')
    grid
    hold on
    plot(xlim,[err_top(indice(1)),err_top(indice(1))],'c--','linewidth',2) 
    plot(xlim,[err_top(indice(2)),err_top(indice(2))],'r--','linewidth',2)
    plot(xlim,[err_top(indice(3)),err_top(indice(3))],'b--','linewidth',2)
    plot(xlim,[err_top(indice(4)),err_top(indice(4))],'m--','linewidth',2)
    hold off
subplot(2,2,[2,4])
plot(err_qe,err_top,'xb')
hold on
plot(err_qe(indice),err_top(indice),'xr','linewidth',3);
hold off
title('Representaci�n XY de los Errores');
xlabel('Error de Cuantizaci�n');
ylabel('Error Topol�gico');

% Saca el error por pantalla para todos los criterios.
disp('e_qe  ,  e_top');
Resultados=[err_qe(indice)',err_top(indice)']
indice'