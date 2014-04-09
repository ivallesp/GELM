%% Representa resultados del SOM
% Mapas de ret�culas
% Hits
% K-Means

clear
close all


load datosSOM
carga_datos
data=datos;


%% Crea el Data Struct
echo off
sD = som_data_struct(data);

%% Normaliza
sD = som_normalize(sD,'var');
nombres_variables=names;
indice=input('Introduce el n�mero del SOM a representar: ');
elegido=['./maps/som_',num2str(indice)];
feval('load',elegido);

sM.comp_names=nombres_variables; % A�ade los nombres


%% Determinaci�n de neuronas ganadoras y hits
[bmus(:,1),bmus(:,2)] = som_bmus(sM,sD);
h=som_hits(sM,sD);

%% Visualizaci�n
%% Mapa Variables
figure
long=length(nombres_variables);
som_show(sM,'comp',1:long,'norm','d');

%% Mapa Hits
figure
som_show(sM,'empty','N�mero de ganadoras')
som_show_add('hit',h,'MarkerColor','b','Subplot',1)

%% K-Means (Determinando clusters de los datos
figure
[c, p, err, ind] = kmeans_clusters(sM); % find clusterings
[dummy,i] = min(ind); % select the one with smallest index
som_show(sM,'color',{p{i},sprintf('%d clusters',i)}); % visualize
colormap(jet(i)), som_recolorbar % change colormap

 

 