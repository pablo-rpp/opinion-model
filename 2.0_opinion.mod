param N; #Número de participantes
param T; #Tiempo de evolución
param I; #Número de intervalos
set TT := {1 .. T}; 
set TTnull := {0 .. T};
set II := {1 .. I};
set II_inner := {2 .. I-1};
param Omega{II}; #Población dividida en intervalos
param Costs{II}; #Costes de publicidad
var P {II}, integer; #Publicistas por intervalo
var P_total;
var S {II, TTnull}; #Densidad de intervalos

minimize advertisement: sum {i in II}(P[i]*Costs[i]);

#Definición de P_total
subject to P_total_def: P_total = sum{i in II}(P[i]);

#La publicidad debe ser, al menos, 0
subject to adv_noneg {i in II}: P[i]>= 0;


#Condiciones iniciales
subject to initial_sets {i in II}: S[i, 0] = (Omega[i] + P[i])/(N+P_total);

#Evolución de los intervalos interiores
subject to evolution_inner {j in II_inner, t in TT}:
    S[j, t] = S[j, t-1] + (2/(N+P_total))*((S[j+1, t-1] - S[j, t-1])*sum{i in 1 .. j}(S[i, t-1])
              + (S[j-1, t-1] - S[j, t-1])*sum{k in j .. I }(S[k, t-1]) + 2*S[j, t-1]^2);

#Evolución del primer intervalo
subject to evolution_ext1 {t in TT}: S[1, t] = S[1, t-1] + (2/(N+P_total))*((S[2, t-1] - S[1, t-1])*sum{i in 1 .. 1}(S[i, t-1])
          - (S[1, t-1])*sum{k in 1 .. I }(S[k, t-1]) + 2*S[1, t-1]^2);

#Evolución del primer intervalo
subject to evolution_extN {t in TT}: S[I, t] = S[I, t-1] + (2/(N+P_total))*((- S[I, t-1])*sum{i in 1 .. I}(S[i, t-1])
          + (S[I-1, t-1] - S[I, t-1])*sum{k in I .. I }(S[k, t-1]) + 2*S[I, t-1]^2);

#Condición de éxito
subject to success: sum{j in 35..I}(S[j, T]) >= 0.25;

#Límite de publicidad
subject to limit {i in II}: P[i] <= Omega[i];
