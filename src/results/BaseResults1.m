addpath ../neurons;
addpath ../odes;

tspan = 0:0.025:1000-0.025;

%% FS
i_ext=1;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(1, @(t) i_ext, 1);
U0 = horzcat(U0, neurons(1).ics);


[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

subplot(1, 3, 1);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% RSA
i_ext=1;

U0 = [];
neurons = FS.empty;

neurons(end+1) = RSA(1, @(t) i_ext, 1);
U0 = horzcat(U0, neurons(1).ics);


[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

subplot(1, 3, 2);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% IB
i_ext=0.5;

U0 = [];
neurons = FS.empty;

neurons(end+1) = IB(1, @(t) i_ext, 1);
U0 = horzcat(U0, neurons(1).ics);


[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

subplot(1, 3, 3);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')