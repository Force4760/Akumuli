import unittest

import tokens, ast, parser, lexer

test "Integers":
    let p = newParser(@[
        (KvalI, "123"), (KvalI, "-123"), (KvalI, "0")
    ])

    let want = $(@[newI(123), newI(-123), newI(0)])

    let got = $( p.parse() )

    require got == want

test "Floats":
    let p = newParser(@[
        (KvalF, "123.2"), (KvalF, "-1.23"), (KvalF, "0.0")
    ])

    let want = $(@[newF(123.2), newF(-1.23), newF(0.0)])

    let got = $( p.parse() )

    require got == want


test "Bools":
    let p = newParser(@[
        (Ktrue, "true"), (Kfalse, "false")
    ])

    let want = $(@[newB(true), newB(false)])

    let got = $( p.parse() )

    require got == want


test "Chars":
    let p = newParser(@[
        (KvalC, "1"), (KvalC, "-"), (KvalC, "w")
    ])

    let want = $(@[newC('1'), newC('-'), newC('w')])

    let got = $( p.parse() )

    require got == want


test "Word":
    let p = newParser(@[
        (KdefW, "@"), (Kunknown, "test"), (KvalI, "12"),
        (KvalF, "0.1"), (Kend, ";")
    ])

    let want = $(@[newWord("test", @[newI(12), newF(0.1)])])

    let got = $( p.parse() )

    require got == want


test "For":
    let p = newParser(@[
        (Kfor, "for"), (KvalI, "12"), (KvalF, "0.1"), (Kend, ";")
    ])

    let want = $(@[newFor(@[newI(12), newF(0.1)])])

    let got = $( p.parse() )

    require got == want

test "Ever":
    let p = newParser(@[
        (Kever, "ever"), (KvalI, "12"), (KvalF, "0.1"), (Kend, ";")
    ])

    let want = $(@[newEver(@[newI(12), newF(0.1)])])

    let got = $( p.parse() )

    require got == want

test "If":
    let p = newParser(@[
        (Kif, "if"), (KvalI, "12"), (KvalI, "1"), (Kend, ";")
    ])

    let want = $(@[newIf(@[newI(12), newI(1)], @[])])

    let got = $( p.parse() )

    require got == want


test "If-Else":
    let p = newParser(@[
        (Kif, "if"), (KvalI, "12"), (KvalI, "1"),
        (Kelse, "else"), (KvalI, "1"), (Ktrue, "true"),
        (Kend, ";")
    ])

    let want = $(@[newIf(
        @[newI(12), newI(1)], @[newI(1), newB(true)]
    )])

    let got = $( p.parse() )

    require got == want


test "Full program":
    let src = """
@ w 2 add ;

true if
  1 2 add
  false if sub 1.2;
else
  w
  for 1 ;
;

    """
    let lex = newLexer( src )
    let par = newParser( lex.tokenize() )

    let want = $(@[
        newWord("w", @[newI(2), newOp(Kadd, "add")]),
        newB(true), newIf(
            @[newI(1), newI(2), newOp(Kadd, "add"), newB(false), newIf(
                @[newOp(Ksub, "sub"), newF(1.2)], @[]
            )],
            @[newUk("w"), newFor(
                @[newI(1)]
            )]
        )
    ])
    let got = $( par.parse() )

    require got == want