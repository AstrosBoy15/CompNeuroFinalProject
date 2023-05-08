addpath ../neurons;
addpath ../odes;

tspan = 0:0.025:400-0.025;

%% FS-FS
i_ext=8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = FS(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

figure;
subplot(2, 3, 4);
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

subplot(2, 3, 1);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% RSA-FS
i_ext = 16;

U0 = [];
neurons = FS.empty;

neurons(end+1) = RSA(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0');

% figure;
subplot(2, 3, 5);
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

subplot(2, 3, 2);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')

%% IB-FS
i_ext = 8;

U0 = [];
neurons = FS.empty;

neurons(end+1) = IB(1, @(t) clickTrain(t, 40, i_ext), 1);
U0 = horzcat(U0, neurons(1).ics);

[t,u] = ode45(@(t,u) fullSystem(t, u, neurons), tspan, U0'); 

% figure;
subplot(2, 3, 6);
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

subplot(2, 3, 3);
plot(t, u(:, 1))
ylim([-85, 60])
xlabel('Time (ms)')
ylabel('Voltage (mV)')