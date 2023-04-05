tspan = [0, 100]; 
i_ext=0.5;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(1, i_ext, 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(1, 0, 5);
U0 = horzcat(U0, neurons(2).ics);
neurons(2).electrical_connections(end+1, :) = [1, 0.2];

neurons(end+1) = FS(1, 0, 9);
U0 = horzcat(U0, neurons(3).ics);
neurons(3).electrical_connections(end+1, :) = [2, 0.2];

neurons(end+1) = FS(1, 0, 13);
U0 = horzcat(U0, neurons(4).ics);
neurons(4).electrical_connections(end+1, :) = [3, 0.2];

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

plot(t, u(:, [1, 5, 9, 13]))