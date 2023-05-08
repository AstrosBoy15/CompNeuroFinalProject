addpath ../neurons;
addpath ../odes;

tspan = 0:0.025:400-0.025;

%% FS-FS 1
i_ext=8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 5);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 0]; % 0.1 - 1, 0.75 - 2/3, 1 - 1/2, 25 - 1/3

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

figure;
subplot(6, 3, 4);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 1);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% FS-FS 2
i_ext=8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 5);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 1]; % 0.1 - 1, 0.75 - 2/3, 1 - 1/2, 25 - 1/3

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

% figure;
subplot(6, 3, 10);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 7);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% FS-FS 3
i_ext=8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 5);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 25]; % 0.1 - 1, 0.75 - 2/3, 1 - 1/2, 25 - 1/3

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

% figure;
subplot(6, 3, 16);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 13);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% RSA-FS 1
i_ext = 16;

U0 = [];
neurons = FS.empty;

neurons(end+1) = RSA(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 6);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 0]; % 0 - 1, 0.75 - 2, 25 - 3 

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0');

% figure;
subplot(6, 3, 5);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 2);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% RSA-FS 2
i_ext = 16;

U0 = [];
neurons = FS.empty;

neurons(end+1) = RSA(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 6);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 0.75]; % 0 - 1, 0.75 - 2, 25 - 3 

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0');

% figure;
subplot(6, 3, 11);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 8);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% RSA-FS 3
i_ext = 16;

U0 = [];
neurons = FS.empty;

neurons(end+1) = RSA(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 6);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 25]; % 0 - 1, 0.75 - 2, 25 - 3 

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0');

% figure;
subplot(6, 3, 17);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 14);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% IB-FS 1
i_ext = 8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = IB(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 8);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 0]; % 0 - 1, 0.1 - 2, 1 - 3, 15 - 4

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

% figure;
subplot(6, 3, 6);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 3);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% IB-FS 2
i_ext = 8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = IB(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 8);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 0.1]; % 0 - 1, 0.1 - 2, 1 - 3, 15 - 4

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

% figure;
subplot(6, 3, 12);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 9);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% IB-FS 3
i_ext = 8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = IB(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

neurons(end+1) = FS(0, @(t) 0, 8);
U0 = horzcat(U0, neurons(2).ics);

neurons(2).electrical_connections(end+1, :) = [1, 0.2];
neurons(1).chemical_connections(end+1, :) = [2, neurons(2).V_syn, 1]; % 0 - 1, 0.1 - 2, 1 - 3, 15 - 4

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

% figure;
subplot(6, 3, 18);
y = detrend(u(:, 1));
Y = fft(y);
L = length(tspan);
Fs = 1000/0.025;

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f, P1)
xlim([0, 50])
ylim([0, 16])
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(6, 3, 15);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')