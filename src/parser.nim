import strutils, strformat, sugar
import ast, tokens, helper


type Parser = ref object
    toks : seq[Token]
    ast  : seq[Node]
    index: int
    size : int


## Type constructor for the parser
proc newParser*(toks: seq[Token]): Parser =
    return Parser(toks: toks, ast: @[], index: -1, size: len(toks))


## Raise an error
proc err*(before, after: string) =
    let b = colorPrple( before )
    let a = colorPrple( after  )
    raise newException(
        ValueError, fmt"Unexpected {a} after {b}"
    )


## get the current token or EOF
proc peekCurr(p: Parser): Token =
    if p.index >= p.size:
        return (KEOF, "EOF")
    return p.toks[p.index]


## Get the next token or EOF
proc peekNext(p: Parser): Token =
    if p.index + 1 >= p.size:
        return (KEOF, "EOF")
    return p.toks[p.index + 1]


## Advance the parser and raise err if passes the EOF
proc next(p: Parser) =
    if p.index + 1 >= p.size:
        err(p.peekCurr().literal, "EOF")
    p.index += 1


## Parse a sequence of tokens
## parses each token according to `f`
## stops at the first token in `untils`
proc parseUntil(p: Parser, f: Parser -> Node, untils: seq[TokenKind]): seq[Node] =
    var nodes: seq[Node] = @[]

    while p.peekNext.kind notin untils:
        p.next()
        nodes.add( f(p) )

    return nodes


## Parse a loop of the form
##     <loop> <...> ;
proc parseLoop(p: Parser, f: Parser -> Node, new: seq[Node] -> Node): Node =
    let nodes = p.parseUntil(f, @[Kend])
    p.next()
    return new(nodes)


## Parse a word of the form
##     : <word> <...> ;
proc parseWord(p: Parser, f: Parser -> Node): Node =
    p.next()
    let word = p.peekCurr()

    if word.kind != Kunknown:
        err(":", p.peekCurr().literal)

    let nodes = p.parseUntil(f, @[Kend])
    p.next()

    return newWord(word.literal, nodes)


## Parse a if-else of the forms
##     if <...> ;
##     if <...> else <...> ;
proc parseIf(p: Parser, f: Parser -> Node): Node =
    let nodesIf = p.parseUntil(f, @[Kend, Kelse])
    p.next()

    if p.peekCurr().kind == Kend:
        return newIf(nodesIf, @[])

    let nodesElse = p.parseUntil(f, @[Kend])
    p.next()

    return newIf(nodesIf, nodesElse)


## Parse the token stream according to the current token
proc parseCurr*(p: Parser): Node =
    let tok = p.peekCurr()
    case tok.kind:
    of Kdup, Kdup2, Kdrop, Kswap, Kover, Krot, Ksize,
       Kadd, Ksub, Kmul, Kdiv, Kmod, Kinc, Kdec, Kmin, Kmax,
       Klt, Kleq, Kgt, Kgeq, Keq, Kneq,
       Kand, Kor, Knot, Kupper, Klower,
       Kto, Kis, Kcross, Kback,
       Kprint, Kinput, Kecho, Kindex:
        return newOp(tok.kind, tok.literal)

    of KvalI : return newI(parseInt(tok.literal))
    of KvalF : return newF(parseFloat(tok.literal))
    of Ktrue : return newB(true)
    of Kfalse: return newB(false)
    of KvalC :
        if tok.literal == "\n": return newC('\n')
        if tok.literal == "\t": return newC('\t')
        return newC(tok.literal[0])

    of KdefW : return p.parseWord( parseCurr           )
    of Kfor  : return p.parseLoop( parseCurr, newFor   )
    of Kever : return p.parseLoop( parseCurr, newEver  )
    of Kwhile: return p.parseLoop( parseCurr, newWhile )
    of Kif   : return p.parseIf(   parseCurr           )

    of Kunknown: return newUk(tok.literal)
    else:
        let t = colorPrple( tok.literal )
        raise newException(ValueError, fmt"Invalid token {t}")


## Parse the intire token stream
## Raises ValuError if the token sequence is not valid
proc parse*(p: Parser): seq[Node] =
    while p.peekNext().kind != KEOF:
        p.next()
        p.ast.add( p.parseCurr() )

    return p.ast