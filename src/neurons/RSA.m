classdef RSA < Neuron
    properties
        C_M = 1
        V_K = -90
        V_Na = 56
        V_L = -70.3
        V_T = -56.2
        g_K = 6
        g_M = 0.075
        g_Na = 56
        g_L = 2.05E-2
        tau_max = 608

        tau_r = 0.5
        tau_d = 8
        V_syn = 20
        V_0 = -20

        ics = [-60, 0, 0, 1, 0];

        elec
        I_inj
        V_index
       
        electrical_connections
        chemical_connections
    end

    methods
        function obj = RSA(elec, I_inj, V_index)
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
            numDiffEqs = 5;
            if obj.elec == 0
                numDiffEqs = numDiffEqs + 1;
            end
        end

        function dUdt = getDiffEqs(obj, U, neurons, electrical_properties, ...
                chemical_properties)
            V = U(1);
            n = U(2);
            m = U(3);
            h = U(4);
            p = U(5);

            a_n = (V-obj.V_T-15)*-0.032/(exp(-(V-obj.V_T-15)/5)-1);
            a_m = (V-obj.V_T-13)*-0.32/(exp(-(V-obj.V_T-13)/4)-1);
            a_h = 0.128*exp(-(V-obj.V_T-17)/18);
            b_n = 0.5*exp(-(V-obj.V_T-10)/40);
            b_m = 0.28*(V-obj.V_T-40)/(exp((V-obj.V_T-40)/5)-1);
            b_h = 4/(exp(-(V-obj.V_T-40)/5)+1);
            p_inf = 1/(exp(-(V+35)/10)+1);
            tau_p = obj.tau_max/(3.3*exp((V+35)/20)+exp(-(V+35)/20));

            dUdt(1) = 1/obj.C_M * (obj.I_inj - obj.g_K*n^4*(V-obj.V_K) - ...
                obj.g_M*p*(V-obj.V_K) - obj.g_Na*m^3*h*(V-obj.V_Na)  - ...
                obj.g_L*(V-obj.V_L));
            dUdt(2) = a_n*(1-n) - b_n*n;
            dUdt(3) = a_m*(1-m) - b_m*m;
            dUdt(4) = a_h*(1-h) - b_h*h;
            dUdt(5) = (p_inf-p) / tau_p;

            if obj.elec == 0
                r = U(6);
                dUdt(6) = (1/obj.tau_r - 1/obj.tau_d)*(1-r) / ...
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