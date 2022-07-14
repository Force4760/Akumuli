type TokenKind* = enum
    Kdup, Kdup2, Kdrop, Kswap, Kover, Krot, Ksize, Kcross, Kback,
    Kadd, Ksub, Kmul, Kdiv, Kmod, Kinc, Kdec, Kmin, Kmax,
    Klt, Kleq, Kgt, Kgeq, Keq, Kneq,
    Kand, Kor, Knot, Kupper, Klower,
    Kif, Kelse, Kfor, Kwhile, Kindex, Kever, KdefW, Kend,
    Kto, Kis, KvalI, KvalF, KvalB, KvalC, Ktrue, Kfalse,
    Kunknown, KEOF, Kprint, Kinput, Kecho, Kquit


type Token* = tuple
    kind: TokenKind
    literal: string