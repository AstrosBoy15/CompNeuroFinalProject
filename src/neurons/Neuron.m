classdef (Abstract) Neuron < matlab.mixin.Heterogeneous
    properties (Abstract)
        elec
        I_inj
        V_index
       
        electrical_connections
        chemical_connections
    end

    methods (Abstract)
        numDiffEqs = getNumDiffEqs(obj)
        dUdt = getDiffEqs(obj, U, neurons, electrical_properties, chemical_properties)
    end
end