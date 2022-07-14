import strformat, strutils, sequtils, sugar

import tokens, helper


type Lexer* = ref object
    src:  seq[string]
    toks: seq[Token]


proc newLexer*(source: string): Lexer =
    let src = source
        .replace("\n", " " )
        .replace("\t", " " )
        .replace("\r", " " )
        .replace(";", " ; ")
        .replace("@", " @ ")
        .split(" ")
        .filter((x) => len(x) > 0)

    return Lexer(src: src, toks: @[])


proc getToken*(str: string): Token =
    case str:
    of "dup"  : return (Kdup  , str)
    of "dup2" : return (Kdup2 , str)
    of "drop" : return (Kdrop , str)
    of "swap" : return (Kswap , str)
    of "over" : return (Kover , str)
    of "rot"  : return (Krot  , str)
    of "size" : return (Ksize , str)

    of "cross": return (Kcross, str)
    of "back" : return (Kback , str)

    of "add"  : return (Kadd  , str)
    of "sub"  : return (Ksub  , str)
    of "mul"  : return (Kmul  , str)
    of "div"  : return (Kdiv  , str)
    of "mod"  : return (Kmod  , str)
    of "inc"  : return (Kinc  , str)
    of "dec"  : return (Kdec  , str)
    of "min"  : return (Kmin  , str)
    of "max"  : return (Kmax  , str)

    of "and"  : return (Kand  , str)
    of "or"   : return (Kor   , str)
    of "not"  : return (Knot  , str)

    of "upper": return (Kupper, str)
    of "lower": return (Klower, str)

    of "less" : return (Klt   , str)
    of "great": return (Kgt   , str)
    of "leq"  : return (Kleq  , str)
    of "geq"  : return (Kgeq  , str)
    of "eq"   : return (Keq   , str)
    of "neq"  : return (Kneq  , str)

    of "toI", "toF", "toB", "toC":
        return (Kto, str)
    of "isI", "isF", "isB", "isC":
        return (Kis, str)

    of "quit" : return (Kquit , str)
    of "print": return (Kprint, str)
    of "echo" : return (Kecho , str)
    of "input", "inputStr":
        return (Kinput, str)

    of "if"   : return (Kif   , str)
    of "else" : return (Kelse , str)
    of "for"  : return (Kfor  , str)
    of "i"    : return (Kindex, str)
    of "ever" : return (Kever , str)
    of "while": return (Kwhile, str)
    of "@"    : return (KdefW , str)
    of ";"    : return (Kend  , str)

    of "true" : return (Ktrue , str)
    of "false": return (Kfalse, str)
    of "''"   : return (KvalC , " ")
    of "'\\n'": return (KvalC , "\n")
    of "'\\t'": return (KvalC , "\t")
    else:
        if isAnInt(str):
            return (KvalI, str)
        if isAFloat(str):
            return (KvalF, str)
        if isAChar(str):
            return (KvalC, $str[1])
        if isValid(str):
            return (Kunknown, str)

        raise newException(
            ValueError, fmt"Can't parse {colorPrple(str)} as a valid token."
        )


proc tokenize*(lex: Lexer): seq[Token] =
    for i in lex.src:
        lex.toks.add( getToken(i) )

    return lex.toks