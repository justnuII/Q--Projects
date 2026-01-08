namespace TP{
    operation QuantumTeleport(msg : Qubit, target : Qubit) : Unit{
        use aliceQubit = Qubit();
        H(aliceQubit);
        CNOT(aliceQubit, target);
        CNOT(msg, aliceQubit);
        H(msg);

        let m1 = M(aliceQubit);
        let m2 = M(msg);

        if (m1 == One){
            X(target);
        }
        if (m2 == One){
            Z(target);
        }

        Reset(aliceQubit);
        Reset(msg);
    }  

    operation RunTeleport(num : Int) : (Bool, Double, String) {
        use q = Qubit[2];
        mutable db = 0.0;
        mutable msg = "";
        
        if num == 1 {
            X(q[0]);
            QuantumTeleport(q[0], q[1]);
            let measurement = M(q[1]);
            set db = measurement == One ? 1.0 | 0.0;
            let res = measurement == One;
            set msg = "Квантовая телепортация со значением |1> произошла успешно!";
            ResetAll(q);
            return (res, db, msg);
        }
        elif num == 3 {
            H(q[0]);
            QuantumTeleport(q[0], q[1]);
            H(q[1]);
            let measurement = M(q[1]);
            set db = measurement == Zero ? 1.0 | 0.0;
            let res = measurement == Zero;
            set msg = "Квантовая телепортация с использованием суперпозиции произошла успешно!";
            ResetAll(q);
            return (res, db, msg);
        }
        else {
            QuantumTeleport(q[0], q[1]);
            let measurement = M(q[1]);
            set db = measurement == Zero ? 0.0 | 1.0;
            let res = measurement == Zero;
            set msg = "Квантовая телепортация со значением |0> произошла успешно!";
            ResetAll(q);
            return (res, db, msg);
        }
    }
}