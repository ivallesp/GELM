%% Entrenamiento SOM %%
% Archivos en ./maps
clear
clc
close all

R=1;
mkdir maps % Crea carpeta maps. Si ya existe, saltar� un warning.
carga_datos

%% Preprocesado y creaci�n de data struct
X=datos;
names=names';

echo off

sD = som_data_struct(X); % Se crea el Data Struct para el SOM
sD = som_normalize(sD,'var'); % Normalizaci�n de variables. Escalado Lineal
% Datos relativos a la normalizaci�n en sData.comp_norm

[obs,dim]=size(sD.data);


%% Par�metros y posibilidades
posib1={'randinit','lininit'}; %Tipos de inicializaciones.
Repet=[500,1]; % N� rep. para 'randinit' y para 'lininit'
posib2={'seq', 'batch'}; %Tipos de Algoritmos.
posib3={'gaussian', 'cutgauss', 'ep', 'bubble'}; %Funciones de vecindad



%% Creaci�n de struct togr�fico
sTo=som_topol_struct(sD);



%% Bucles del SOM
for inicia=1:length(posib1) % INICIALIZACIONES 1:Rand; 2:Lineal
    num_rep=Repet(inicia); % Num. de repeticiones en funci�n de "inicia"
    for k=1:num_rep % REPETICIONES
        for algoritmo=1:length(posib2) % ALGORITMOS 1:Secuencial; 2:Batch
            for vec=1:length(posib3) % FUNCIONES DE VECINDAD
                elec3=posib3{vec}; % Argumento para tipo de vecindad
                
                
                %% Creaci�n de map struct
                sM=som_map_struct(dim,'neigh',elec3,'topol',sTo,'comp_names',names);
                
                
                %% Inicializaci�n
                if inicia==1
                    sM=som_randinit(sD,sM); % Aleatoria
                else
                    sM=som_lininit(sD,sM); % Lineal
                end
                
                
                %% Entrenamiento
                if algoritmo==1
                    sM=som_seqtrain(sM, sD, 'tracking', 0); %Rough
                    sM=som_seqtrain(sM, sD, 'tracking', 0); %Finetune
                else
                    sM=som_batchtrain(sM, sD, 'tracking', 0); %Rough
                    sM=som_batchtrain(sM, sD, 'tracking', 0); %Finetune
                end
                
                
                %% Almacenamiento de resultados
                fileName=['./maps/som_' num2str(R)];
                feval('save', fileName, 'sM');
                R=R+1;
                
                
            end
        end
    end
    
end
save datosSOM sD


 