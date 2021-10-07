// https://www.cs.utah.edu/~mflatt/past-courses/cs7520/public_html/s06/notes.pdf


const True  = x => y => x
const False = x => y => y


const If = Bool => x => y => Bool (x) (y)


const Fst = p => p (True )   
const Snd = p => p (False)


const Pair = M => N => Bool => If (Bool) (M) (N)
const MkPair = x => y => f => f (x) (y)


const Zero = f => x => x
const One  = f => x => f (x)
const Two  = f => x => f (f (x))


const Add1  = n => f => x => f (n (f) (x))
const Add   = n => m => m (Add1) (n)


const IsZero = n => n (_ => False) (True)


const Wrap = f => p => MkPair
    (False) 
    (If (Fst (p))
        (Snd (p))
        (f   (Snd (p))))


const Sub1 = n => f => x => Snd
    (n (Wrap (f))
       (Pair (True) (x)))
const Sub  = n => m => m (Sub1) (n)


const Mult = n => m => m (Add (n)) (Zero) 
const MkMult = f => n => m => 
    If (IsZero(n))
    (Zero)
    (Add (m)
        (f(f)
            (Sub1(n)) 
            (m)))
const Mult2 = MkMult(MkMult)


const MkSum = f => n => Add(
    If (IsZero(n))
        (Zero)
        (f(f)
            (Sub1(n))))
const Sum2 = MkSum(MkSum)


const MkMk = f => t => t (f(f) (t))
const Mk   = MkMk (MkMk)


const Null = _ => _ => True
const IsNull = c => 
    If (c(False)(False))
        (True)
        (False)


const Cons = x => y => Check => Bool => 
    If (Check) 
        (If (Bool) (x) (y)) 
        (False)
const Car  = c => Fst (c (True))
const Cdr  = c => Snd (c (True))


const MkLength = f => c => 
    If (IsNull (c))
        (Zero)
        (Add1 (f (Cdr (c))))
// const Length = Mk(MkLength)



// check
const pair = MkPair (False) (1)
const cons = Cons   
    (True)
    (Cons (True) (Null))
const check = [
    IsNull(Null),
    IsNull(cons),
    cons,
    // Mult2(Zero)(Zero), inf
    Mult(One)(Two),
    Mult(Two)(Add1(Two)),
    Add(One)(Two)(x => x + 1)(0),
    Sub1(One)(x => x - 1)(1),
    Sub(Two)(One)(x => x - 1)(1),
    Add1(Zero)(x => x - 1)(2),
    (If (True )) (0) (1),
    (If (False)) (0) (1),
    (If (False)) (0) (If (False)) (1) (2),
    pair (Fst),
    pair (Snd),
    Zero,
    Add1(Zero),
    One,
    Add1(One),
    Two,
    Add(Zero)(One),
    IsZero(Zero),
    IsZero(One ),
]


// log
check.forEach(str => console.log(
    str
))