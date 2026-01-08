namespace Pass {
    import Std.Math.BitSizeI;
    operation RandomNumber(max : Int , useEntanglement : Int) : Int {
        let bitsNeeded = BitSizeI(max);
        
        mutable result = 0;
        for i in 0..bitsNeeded-1 {
            if (useEntanglement == 0){
                use q = Qubit();
                H(q);
                let bit = M(q);
                
                if bit == One {
                    set result = result ||| (1 <<< i);
                }
                Reset(q);
            }
            else {
                use qs = Qubit[2];
                use ranH = Qubit();
                H(ranH);
                if (M(ranH) == One){
                    H(qs[0]);
                }
                else {
                    H(qs[1]);
                }
                Reset(ranH);

                CNOT(qs[0], qs[1]);

                let res1 = M(qs[0]);
                let res2 = M(qs[1]);


                let bit = (res1 == res2) ? 0 | 1;

                if bit == 1 {
                    set result = result ||| (1 <<< i);
                }
                ResetAll(qs);
            }
        }
        
        return result % max;
    }
    operation RandomStr(length : Int, useEntanglement : Int) : String{
        let chars = ["0","1","2","3","4","5","6","7","8","9",
            "A","B","C","D","E","F","G","H","I","J",
            "K","L","M","N","O","P","Q","R","S","T",
            "U","V","W","X","Y","Z",
            "a","b","c","d","e","f","g","h","i","j",
            "k","l","m","n","o","p","q","r","s","t",
            "u","v","w","x","y","z"];

        mutable resultchar = "";

        for i in 1..length{
            let index = RandomNumber(62, useEntanglement);
            set resultchar = resultchar + chars[index]; 
        }

        return resultchar;
    }
    operation Complete(length : Int, useEntanglement : Int) : String{
        mutable CompleteStr = "";

        let digitStrings = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

        let RanStr = RandomStr(length, useEntanglement);

        set CompleteStr = CompleteStr + RanStr;

        return CompleteStr;
    }
    operation GeneratePassword (length : Int, useEntanglement : Int) : String{
        mutable password = "";

        set password = Complete(length, useEntanglement);

        return password;
    }
}