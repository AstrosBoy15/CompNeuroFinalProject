function I = clickTrain(t, freq, strength)
    period = 1000 / freq;
    t_shift = mod(t, period);
    if t_shift < 2
        I = strength;
    else
        I = 0;
    end
end