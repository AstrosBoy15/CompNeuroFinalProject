addpath ../neurons;
addpath ../odes;

tspan = [0, 500]; 
i_ext=0.5;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(0, @(t) 0.35, 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(1, @(t) i_ext, 6);
U0 = horzcat(U0, neurons(2).ics);
neurons(2).chemical_connections(end+1, :) = [1, neurons(1).V_syn, 0.2];

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

plot(t, u(:, [1, 6]))