import unittest

import lexer, tokens


test "Stack ops":
    let lex = newLexer("dup dup2 drop swap over rot size cross back")

    require lex.tokenize() == @[
        (Kdup, "dup"), (Kdup2, "dup2"), (Kdrop, "drop"),
        (Kswap, "swap"), (Kover, "over"), (Krot, "rot"),
        (Ksize, "size"), (Kcross, "cross"), (Kback, "back")
    ]


test "Number Binary ops":
    let lex = newLexer("add sub mul div mod min max")

    require lex.tokenize() == @[
        (Kadd, "add"), (Ksub, "sub"), (Kmul, "mul"), (Kdiv, "div"),
        (Kmod, "mod"), (Kmin, "min"), (Kmax, "max")
    ]


test "Number Unary ops":
    let lex = newLexer("inc dec")

    require lex.tokenize() == @[
        (Kinc, "inc"), (Kdec, "dec"),
    ]


test "Binary ops":
    let lex = newLexer("and or not")

    require lex.tokenize() == @[
        (Kand, "and"), (Kor, "or"), (Knot, "not")
    ]


test "Char ops":
    let lex = newLexer("upper lower")

    require lex.tokenize() == @[
        (Kupper, "upper"), (Klower, "lower"),
    ]


test "Comparisson ops":
    let lex = newLexer("less great leq geq eq neq")

    require lex.tokenize() == @[
        (Klt, "less"), (Kgt, "great"), (Kleq, "leq"),
        (Kgeq, "geq"), (Keq, "eq"), (Kneq, "neq")
    ]


test "Converters and checkers":
    let lex = newLexer("toI toF toB toC isI isF isB isC")

    require lex.tokenize() == @[
        (Kto, "toI"), (Kto, "toF"), (Kto, "toB"), (Kto, "toC"),
        (Kis, "isI"), (Kis, "isF"), (Kis, "isB"), (Kis, "isC"),
    ]


test "If - Else":
    let lex = newLexer("if mul add else sub; mul")

    require lex.tokenize() == @[
        (Kif, "if"), (Kmul, "mul"), (Kadd, "add"),
        (Kelse, "else"), (Ksub, "sub"), (Kend, ";"),
        (Kmul, "mul")
    ]


test "For":
    let lex = newLexer("for mul add ;")

    require lex.tokenize() == @[
        (Kfor, "for"), (Kmul, "mul"), (Kadd, "add"), (Kend, ";")
    ]


test "Ever":
    let lex = newLexer("ever mul add ;")

    require lex.tokenize() == @[
        (Kever, "ever"), (Kmul, "mul"), (Kadd, "add"), (Kend, ";")
    ]


test "Words":
    let lex = newLexer("@test mul add ;")

    require lex.tokenize() == @[
        (KdefW, "@"), (Kunknown, "test"), (Kmul, "mul"),
        (Kadd, "add"), (Kend, ";")
    ]


test "Booleans":
    let lex = newLexer("true false")

    require lex.tokenize() == @[
        (Ktrue, "true"), (Kfalse, "false")
    ]


test "Ints":
    let lex = newLexer("123 012 -44")

    require lex.tokenize() == @[
        (KvalI, "123"), (KvalI, "012"), (KvalI, "-44")
    ]


test "Floats":
    let lex = newLexer("12.3 -01.2 -44.2")

    require lex.tokenize() == @[
        (KvalF, "12.3"), (KvalF, "-01.2"), (KvalF, "-44.2")
    ]


test "Char":
    let lex = newLexer("'1' 'w' '.'")

    require lex.tokenize() == @[
        (KvalC, "1"), (KvalC, "w"), (KvalC, ".")
    ]


test "Error":
    let lex = newLexer("'1' test.test '.'")
    expect ValueError:
     let _ = lex.tokenize()