classdef IB < Neuron
    properties
        C_M = 1
        V_K = -90
        V_Ca = 120
        V_Na = 50
        V_L = -70
        V_T = -56.2
        g_K = 5
        g_M = 0.03
        g_Ca = 0.2
        g_Na = 50
        g_L = 0.01
        tau_max = 608

        tau_r = 0.5
        tau_d = 8
        V_syn = 20
        V_0 = -20

        ics = [-60, 0, 0, 1, 0, 0, 0.4];

        elec
        I_inj
        V_index
       
        electrical_connections
        chemical_connections
    end

    methods
        function obj = IB(elec, I_inj, V_index)
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
            numDiffEqs = 7;
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
            p = U(5);
            q = U(6);
            s = U(7);

            I = obj.I_inj(t);

            a_n = (V-obj.V_T-15)*-0.032/(exp(-(V-obj.V_T-15)/5)-1);
            a_m = (V-obj.V_T-13)*-0.32/(exp(-(V-obj.V_T-13)/4)-1);
            a_h = 0.128*exp(-(V-obj.V_T-17)/18);
            a_q = 0.055*(-27-V)/(exp((-27-V)/3.8)-1);
            a_s = 0.000457*exp((-13-V)/50);
            b_n = 0.5*exp(-(V-obj.V_T-10)/40);
            b_m = 0.28*(V-obj.V_T-40)/(exp((V-obj.V_T-40)/5)-1);
            b_h = 4/(exp(-(V-obj.V_T-40)/5)+1);
            b_q = 0.94*exp((-75-V)/17);
            b_s = 0.0065/(exp((-15-V)/28)+1);
            p_inf = 1/(exp(-(V+35)/10)+1);
            tau_p = obj.tau_max/(3.3*exp((V+35)/20)+exp(-(V+35)/20));

            dUdt(1) = 1/obj.C_M * (I - obj.g_K*n^4*(V-obj.V_K) - ...
                obj.g_M*p*(V-obj.V_K) - obj.g_Ca*q^2*s*(V-obj.V_Ca) - ...
                obj.g_Na*m^3*h*(V-obj.V_Na) - obj.g_L*(V-obj.V_L));
            dUdt(2) = a_n*(1-n) - b_n*n;
            dUdt(3) = a_m*(1-m) - b_m*m;
            dUdt(4) = a_h*(1-h) - b_h*h;
            dUdt(5) = (p_inf-p) / tau_p;
            dUdt(6) = a_q*(1-q) - b_q*q;
            dUdt(7) = a_s*(1-s) - b_s*s;

            if obj.elec == 0
                r = U(8);
                dUdt(8) = (1/obj.tau_r - 1/obj.tau_d)*(1-r) / ...
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