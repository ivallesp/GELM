 function y = coste_elm(w,rho,deseada,lambda)
   
 % En esta parte generamos el coste a minimizar;
 y=mean((deseada-rho*w').^2); %Coste cuadr�tico
 %y=mean(abs(deseada-rho*w')); %Coste absoluto
 %y=mean(abs(deseada-rho*w')) + lambda*sum((w).^2); %Coste Ridge Regression (Regul.)
 %y=mean(abs(deseada-rho*w')) + lambda*sum(abs(w)); %Coste Variaci�n 1 (Regul.)

 end