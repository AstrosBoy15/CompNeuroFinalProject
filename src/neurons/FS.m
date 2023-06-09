classdef FS < Neuron
    properties
        C_M = 0.5
        V_K = -90
        V_Na = 50
        V_L = -70
        V_T = -56.2
        g_K = 10
        g_Na = 56
        g_L = 1.5E-2
        tau_max = 1

        tau_r = 0.5
        tau_d = 8
        V_syn = -80
        V_0 = -20

        ics = [-60, 0, 0, 1];

        elec
        I_inj
        V_index
       
        electrical_connections
        chemical_connections
    end

    methods
        function obj = FS(elec, I_inj, V_index)
            obj.elec = elec;
            obj.I_inj = I_inj;
            obj.V_index = V_index;

            obj.electrical_connections = [];
            obj.chemical_connections = [];

            if obj.elec == 0
                obj.ics(end+1) = 0;
            end
        end

        function numDiffEqs = getNumDiffEqs(obj)
            numDiffEqs = 4;
            if obj.elec == 0
                numDiffEqs = numDiffEqs + 1;
            end
        end

        function dUdt = getDiffEqs(obj, t, U, neurons, electrical_properties, ...
                chemical_properties)
            V = U(1);
            n = U(2);
            m = U(3);
            h = U(4);

            I = obj.I_inj(t);

            a_n = (V-obj.V_T-15)*-0.032/(exp(-(V-obj.V_T-15)/5)-1);
            a_m = (V-obj.V_T-13)*-0.32/(exp(-(V-obj.V_T-13)/4)-1);
            a_h = 0.128*exp(-(V-obj.V_T-17)/18);
            b_n = 0.5*exp(-(V-obj.V_T-10)/40);
            b_m = 0.28*(V-obj.V_T-40)/(exp((V-obj.V_T-40)/5)-1);
            b_h = 4/(exp(-(V-obj.V_T-40)/5)+1);

            dUdt(1) = 1/obj.C_M * (I - obj.g_K*n^4*(V-obj.V_K) - ...
                obj.g_Na*m^3*h*(V-obj.V_Na)  - obj.g_L*(V-obj.V_L));
            dUdt(2) = a_n*(1-n) - b_n*n;
            dUdt(3) = a_m*(1-m) - b_m*m;
            dUdt(4) = a_h*(1-h) - b_h*h;

            if obj.elec == 0
                r = U(5);
                dUdt(5) = (1/obj.tau_r - 1/obj.tau_d)*(1-r) / ...
                    (1 + exp(-V + obj.V_0)) - 1/obj.tau_d*r;
            end

            for i = 1:size(obj.electrical_connections, 1)
                dUdt(1) = dUdt(1) + obj.electrical_connections(i, 2) * ...
                    (electrical_properties(i) - V)/obj.C_M;
            end


            for i = 1:size(obj.chemical_connections, 1)
                dUdt(1) = dUdt(1) + obj.chemical_connections(i, 3) * ...
                    chemical_properties(i)*(obj.chemical_connections(i, 2) - V)/obj.C_M;
            end
        end
    end
end