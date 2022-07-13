import strformat

import helper

type
    ## Value type = Int | Float | Bool | Char
    ValKind = enum KI, KF, KB, KC
    Value* = object
        case kind: ValKind:
        of KI: i: int
        of KF: f: float
        of KB: b: bool
        of KC: c: char



## String representation
func `$`*(v: Value): string =
    let repr = case v.kind:
        of KI: "Int("   & $v.i & ")"
        of KF: "Float(" & $v.f & ")"
        of KB: "Bool("  & $v.b & ")"
        of KC: "Char("  & $v.c & ")"
    return colorGreen(repr)

func getStr*(v: Value): string =
    case v.kind:
    of KI: $v.i
    of KF: $v.f
    of KB: $v.b
    of KC: $v.c



## Error raising functions
func err(op: string, v, u: Value) =
    let o = colorPrple(op)
    raise newException(ValueError,
        fmt"Can't use the {o} operation on values {$v}, {$u}")

func err(op: string, v: Value) =
    let o = colorPrple(op)
    raise newException(ValueError,
        fmt"Can't use the {o} operation on the value {$v}")



## Checkers for the value kind
func isK(v: Value, k: ValKind): bool =
    v.kind == k

func both(v, u: Value, k: ValKind): bool =
    v.kind == k and u.kind == k

func isI*(v: Value): bool = isK(v, KI)
func isF*(v: Value): bool = isK(v, KF)
func isB*(v: Value): bool = isK(v, KB)
func isC*(v: Value): bool = isK(v, KC)

func bothI*(v, u: Value): bool = both(v, u, KI)
func bothF*(v, u: Value): bool = both(v, u, KF)
func bothB*(v, u: Value): bool = both(v, u, KB)
func bothC*(v, u: Value): bool = both(v, u, KC)



## Constructors
func new*(i: int  ): Value = Value(kind: KI, i: i)
func new*(f: float): Value = Value(kind: KF, f: f)
func new*(b: bool ): Value = Value(kind: KB, b: b)
func new*(c: char ): Value = Value(kind: KC, c: c)

## Getters
func getI*(v: Value): int   = v.i
func getF*(v: Value): float = v.f
func getB*(v: Value): bool  = v.b
func getC*(v: Value): char  = v.c



## Converters
func toI*(v: Value): Value =
    if isI(v): return v
    if isF(v): return new( int(v.f) )
    if isB(v): return new( int(v.b) )
    if isC(v): return new( int(v.c) )
    err("toI", v)

func toF*(v: Value): Value =
    if isI(v): return new( float(v.i) )
    if isB(v): return new( float(v.b) )
    if isC(v): return new( float(v.c) )
    err("toF", v)

func toB*(v: Value): Value =
    if isB(v): return v
    if isI(v): return new( bool(v.i)        )
    if isF(v): return new( floatToBool(v.f) )
    if isC(v): return new( v.c != ' '       )
    err("toB", v)

func toC*(v: Value): Value =
    if isC(v): return v
    if isI(v): return new( char(v.i) )
    err("toC", v)



## Numbers
func `+`*(v, u: Value): Value =
    ## Add function: I.I | F.F
    if bothI(v, u): return new( v.i + u.i )
    if bothF(v, u): return new( v.f + u.f )
    err("add", v, u)

func `-`*(v, u: Value): Value =
    ## Sub function: I.I | F.F
    if bothI(v, u): return new( v.i - u.i )
    if bothF(v, u): return new( v.f - u.f )
    err("sub", v, u)

func `*`*(v, u: Value): Value =
    ## Mul function: I.I | F.F
    if bothI(v, u): return new( v.i * u.i )
    if bothF(v, u): return new( v.f * u.f )
    err("mul", v, u)

func `/`*(v, u: Value): Value =
    ## Div function: I.I | F.F
    if bothI(v, u): return new( v.i div u.i )
    if bothF(v, u): return new( v.f  /  u.f )
    err("div", v, u)

func `%`*(v, u: Value): Value =
    ## Mul function: I.I
    if bothI(v, u): return new( v.i mod u.i )
    err("mod", v, u)

func `++`*(v: Value): Value =
    ## Inc function: I | F
    if isI(v): return new( v.i + 1   )
    if isF(v): return new( v.f + 1.0 )
    err("inc", v)

func `--`*(v: Value): Value =
    ## Dec function: I | F
    if isI(v): return new( v.i - 1   )
    if isF(v): return new( v.f - 1.0 )
    err("dec", v)

func min*(v, u: Value): Value =
    ## Min function: I.I | F.F
    if bothI(v, u): return new( min( v.i, u.i ) )
    if bothF(v, u): return new( min( v.f, u.f ) )
    err("min", v, u)

func max*(v, u: Value): Value =
    ## Max function: I.I | F.F
    if bothI(v, u): return new( max( v.i, u.i ) )
    if bothF(v, u): return new( max( v.f, u.f ) )
    err("max", v, u)


## Booleans
func `&&`*(v, u: Value): Value =
    ## And function: B.B
    if bothB(v, u): return new( v.b and u.b )
    err("and", v, u)

func `||`*(v, u: Value): Value =
    ## Or function: B.B
    if bothB(v, u): return new( v.b or u.b )
    err("or", v, u)

func `!`* (v: Value): Value =
    ## Not function: B
    if isB(v): return new( not v.b )
    err("not", v)


## Chars
func lower*(v: Value): Value =
    ## Or function: S
    if isC(v): return new( toLower(v.c) )
    err("lower", v)

func upper*(v: Value): Value =
    ## Or function: S
    if isC(v): return new( toUpper(v.c) )
    err("upper", v)


## Comparisson
func `<`* (v, u: Value): Value =
    ## Lesser than function: I.I | F.F
    if bothI(u, v): return new( v.i < u.i )
    if bothF(u, v): return new( v.f < u.f )
    if bothC(u, v): return new( v.c < u.c )
    err("less", v, u)

func `<=`*(v, u: Value): Value =
    ## Lesser than or equal to function: I.I | F.F
    if bothI(u, v): return new( v.i <= u.i )
    if bothF(u, v): return new( v.f <= u.f )
    if bothC(u, v): return new( v.c <= u.c )
    err("leq", v, u)

func `>`* (v, u: Value): Value =
    ## Greater than function: I.I | F.F
    if bothI(u, v): return new( v.i > u.i )
    if bothF(u, v): return new( v.f > u.f )
    if bothC(u, v): return new( v.c > u.c )
    err("great", v, u)

func `>=`*(v, u: Value): Value =
    ## Greater than or equal to function: I.I | F.F
    if bothI(u, v): return new( v.i >= u.i )
    if bothF(u, v): return new( v.f >= u.f )
    if bothC(u, v): return new( v.c >= u.c )
    err("geq", v, u)

func `==`*(v, u: Value): Value =
    ## Equal function: I.I | F.F | B.B | S.S
    if bothI(u, v): return new( v.i == u.i )
    if bothF(u, v): return new( v.f == u.f )
    if bothB(u, v): return new( v.b == u.b )
    if bothC(u, v): return new( v.c == u.c )
    err("eq", v, u)

func `!=`*(v, u: Value): Value =
    ## Not Equal function: I.I | F.F | B.B | S.S
    if bothI(u, v): return new( v.i != u.i )
    if bothF(u, v): return new( v.f != u.f )
    if bothB(u, v): return new( v.b != u.b )
    if bothC(u, v): return new( v.c != u.c )
    err("neq", v, u)