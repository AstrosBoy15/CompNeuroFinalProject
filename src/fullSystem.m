function dUdt = fullSystem(t, U, neurons)
    dUdt = [];
    i = 1;
    for neuron = neurons
        voltages = [];
        receptors = [];

        for j = 1:size(neuron.electrical_connections, 1)
            voltages(end+1) = U(neurons(neuron.electrical_connections(j, 1)).V_index);
        end

        for j = 1:size(neuron.chemical_connections, 1)
            presyn_neuron = neurons(neuron.chemical_connections(j, 1));
            receptors(end+1) = U(presyn_neuron.V_index+getNumDiffEqs(presyn_neuron)-1);
        end

        dWdt = getDiffEqs(neuron, U(i:i+getNumDiffEqs(neuron)-1), neurons, voltages, receptors);
        i = i + getNumDiffEqs(neuron);
        for dx = dWdt
            dUdt(end+1) = dx;
        end
    end

    dUdt = dUdt';
end