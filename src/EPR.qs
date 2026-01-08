namespace EPR {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation RunERP(count : Int) : (Int , Int , Int, Int){
        mutable founded00 = 0;
        mutable founded11 = 0;
        mutable founded01 = 0;
        mutable founded10 = 0;

        for _ in 1..count{
            use qs = Qubit[2];
            H(qs[0]);
            CNOT(qs[0], qs[1]);

            use q = Qubit();
            H(q);
            let ran = M(q);

            if (ran == One){
                X(qs[1]);
                X(q);
            }

            use qs2 = Qubit[2];
            H(qs2[0]);
            CNOT(qs2[0], qs2[1]);

            let rand1 = M(qs[0]);
            let rand2 = M(qs[1]);

            if (rand1 == Zero and rand2 == Zero){
                X(qs[1]);
                Rx(3.14, qs[0]);
                Ry(1.57, qs[1]);
            }
            elif (rand1 == Zero and rand2 == One){
                Rx(0.01, qs[0]);
                Ry(0.01, qs[1]);
            }
            elif (rand1 == One and rand2 == One){
                Rx(2.0, qs[0]);  
                Ry(2.0, qs[1]);
                Rz(2.0, qs[0]);
                Rz(2.0, qs[1]);
                X(qs[0]);
                X(qs[1]);
            }
            else {
                Rx(3.0, qs[0]);
                Ry(3.0, qs[1]);
                Rz(3.0, qs[0]);
                Rz(3.0, qs[1]);
                X(qs[0]);
                H(qs[0]);
                H(qs[1]);
            }

            ResetAll(qs2);

            let res1 = M(qs[0]);
            let res2 = M(qs[1]);

            if (res1 == Zero and res2 == Zero){
                set founded00 += 1;
            }
            elif (res1 == One and res2 == One) {
                set founded11 += 1;
            }
            elif (res1 == Zero and res2 == One){
                set founded01 += 1;
            }
            elif (res1 == One and res2 == Zero){
                set founded10 += 1;
            }

            ResetAll(qs);
        }
        return (founded00, founded01, founded10, founded11);
    }
}