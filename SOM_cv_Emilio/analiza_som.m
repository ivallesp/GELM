%%%%FICHERO PARA ANALIZAR LOS SOM OBTENIDOS %%%%%%%%%

clear
clc
close all
load datosSOM;
%%%%N es el n�mero de SOM que gener�is %%%%%%
N=8000;
err_top=zeros(1,N);
err_qe=err_top;

for R=1:N,

  %%% %% CARGAMOS EL SOM CORRESPONDIENTE %%%%%%
mejorsom=['./maps/som_' num2str(R)]; 
feval('load', mejorsom); 
%%%%%DETERMINAMOS SU ERROR DE CUANTIZACI�N %%%%%
%%%%%Y SU ERROR TOPOGR�FICO %%%%%%%%%%%%%%%%%%

[qe,te] = som_quality(sM,sData);
err_top(R)=te;
err_qe(R)=qe;
R;
%%%%%%%%%%%%%%%%%%%%%%%%

end
   
%%%%se guardan los dos errores; el de cuantizaci�n da idea de lo bien que
%%%%representa a los datos y el topogr�fico da idea de si se mantienen las
%%%%relaciones de vecindad %%%%%%%%%%%%%%%%%%%%%%%%%%

save resultados_analisis_som err_top err_qe
