namespace UC{
    import Std.Math.BitSizeI;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Random;

    operation CZ(target : Qubit[]) : Unit is Adj + Ctl{
        let length = Length(target);
        if length == 1{
            Z(target[0]);
        }
        else {
            let controls = target[0..length-2];
            let tar = target[length-1];

            Controlled Z(controls, tar);
        }
    }

    operation MarkSecretNumber(register : Qubit[], secetnum : Int):Unit is Adj + Ctl{
        let length = Length(register);
        for i in 0..length-1{
            if ((secetnum >>> i) &&& 1 == 0){
                X(register[i]);
            }
        }

        CZ(register);

        for i in 0..length-1{
            if ((secetnum >>> i) &&& 1 == 0){
                X(register[i]);
            }
        }
    }
    operation GroverDiffusion(register : Qubit[]) : Unit is Adj + Ctl {

        let n = Length(register);

        for i in 0..n-1{
            H(register[i]);
        }
        
        for i in 0..n-1{
            X(register[i]);
        }


        CZ(register);
        
        for i in 0..n-1{
            X(register[i]);
        }
        
        for i in 0..n-1{
            H(register[i]);
        }
    }


    operation FindSecretNumber(secretNumber : Int, maxValue : Int) : Int {
        let nQubits = BitSizeI(maxValue);
        
        mutable foundNumber = 0;
        use register = Qubit[nQubits];
        
        ApplyToEach(H, register);
        
        let iterations = 1 + (DrawRandomInt(0, 2) % 3);
        for _ in 1..iterations {
            MarkSecretNumber(register, secretNumber);
            GroverDiffusion(register);
        }
        
        mutable bits = 0;
        for i in 0..nQubits-1 {
            if MResetZ(register[i]) == One {
                set bits = bits ||| (1 <<< i);
            }
        }
        
        if bits > maxValue {
            set foundNumber = bits % (maxValue + 1);
        } else {
            set foundNumber = bits;
        }
        
        return foundNumber;
    }
}