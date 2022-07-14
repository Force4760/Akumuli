import std/tables, std/strformat, std/strutils
import stack, ast, tokens, value, helper

type Program* = ref object
    ast : seq[Node]

    stk : Stk[Value]
    side: Stk[Value]

    words: TableRef[string, seq[Node]]
    loopI: int


func newProgram*(ast: seq[Node]): Program =
    Program(
        ast: ast,
        stk: newStk(Value),
        side: newStk(Value),
        words: newTable[string, seq[Node]](),
        loopI: 0,
    )


proc input(p: Program, s: string) =
    let inpt = stdin.readline().strip()
    if s == "inputStr":
        for i in reverse(inpt):
            p.stk.push( new( i ) )
        return

    if inpt == "true":
        p.stk.push( new( true ) )
    elif inpt == "false":
        p.stk.push( new( false ) )
    elif isAnInt(inpt):
        p.stk.push( new( parseInt(inpt) ) )
    elif isAFloat(inpt):
        p.stk.push( new( parseFloat(inpt) ) )
    elif isAChar(inpt):
        p.stk.push( new( inpt[1] ) )
    elif len(inpt) == 1:
        p.stk.push( new( inpt[0] ) )
    else:
        raise newException(ValueError, "Invalid input")


proc echo(p: Program) =
    if p.stk.len() == 0:
        let o = colorPrple("echo")
        raise newException(ValueError, "Can't use {o} on an empty stack.")

    if not isC( p.stk.peek() ):
        let o = colorPrple("echo")
        raise newException(ValueError, fmt"Can't use {o} on {$p.stk.pop()}")

    while p.stk.len() > 0 and isC( p.stk.peek() ):
        let a = p.stk.pop()
        stdout.write getStr(a)


proc evalOp(p: Program, op: TokenKind, str: string) =
    case op:
    of Kdup : p.stk.dup()
    of Kdup2: p.stk.dup2()
    of Kdrop: p.stk.drop()
    of Kswap: p.stk.swap()
    of Kover: p.stk.over()
    of Krot : p.stk.rot()
    of Ksize: p.stk.size(new)
    of Kcross:
        let a = p.stk.pop()
        p.side.push( a )
    of Kback:
        let a = p.side.pop()
        p.stk.push( a )
    of Kadd:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a + b )
    of Ksub:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a - b )
    of Kmul:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a * b )
    of Kdiv:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a / b )
    of Kmod:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a % b )
    of Kinc:
        let a = p.stk.pop()
        p.stk.push( ++a )
    of Kdec:
        let a = p.stk.pop()
        p.stk.push( --a )
    of Kmin:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( min(a, b) )
    of Kmax:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( max(a, b) )
    of Kand:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a && b )
    of Kor:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a || b )
    of Knot:
        let a = p.stk.pop()
        p.stk.push( !a )
    of Kupper:
        let a = p.stk.pop()
        p.stk.push( upper(a) )
    of Klower:
        let a = p.stk.pop()
        p.stk.push( lower(a) )
    of Klt:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a < b )
    of Kgt:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a > b )
    of Kleq:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a <= b )
    of Kgeq:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a >= b )
    of Keq:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a == b )
    of Kneq:
        let a = p.stk.pop()
        let b = p.stk.pop()
        p.stk.push( a != b )
    of Kto:
        let a = p.stk.pop()
        if   str == "toI": p.stk.push( toI(a) )
        elif str == "toF": p.stk.push( toF(a) )
        elif str == "toB": p.stk.push( toB(a) )
        elif str == "toC": p.stk.push( toC(a) )

    of Kis:
        let a = p.stk.pop()
        if   str == "isI": p.stk.push( new( isI(a) ) )
        elif str == "isF": p.stk.push( new( isF(a) ) )
        elif str == "isB": p.stk.push( new( isB(a) ) )
        elif str == "isC": p.stk.push( new( isC(a) ) )

    of Kecho:
        p.echo()
    of Kprint:
        let a = p.stk.pop()
        echo getStr( a )
    of Kinput:
        p.input( str )
    of Kquit:
       let a  = toI( toB( p.stk.pop() ) )
       quit( getI( a ) )
    of Kindex:
        p.stk.push( new(p.loopI) )
    else:
        raise newException(ValueError, "Invalid operation")


proc eval(p: Program, node: Node) =
    case node.kind:
    of nkI:
        p.stk.push(new( node.iV ))
    of nkF:
        p.stk.push(new( node.fV ))
    of nkB:
        p.stk.push(new( node.bV ))
    of nkC:
        p.stk.push(new( node.cV ))
    of nkWord:
        p.words[node.word] = node.wordV

    of nkFor:
        let times = getI( toI( p.stk.pop() ) )
        for i in 0 ..< times:
            p.loopI = i
            for x in node.forV:
                p.eval(x)
        p.loopI = 0

    of nkEver:
        while true:
            for x in node.everV:
                p.eval(x)
    of nkWhile:
        while p.stk.len() > 0:
            for x in node.whileV:
                p.eval(x)

    of nkIf:
        let cond = getB( toB( p.stk.pop() ) )
        if cond:
            for i in node.ifV:
                p.eval(i)
        else:
            for i in node.elseV:
                p.eval(i)

    of nkUk:
        if node.ukV in p.words:
            for i in p.words[node.ukv]:
                p.eval(i)
        else:
            let w = colorGreen(node.ukV)
            raise newException(ValueError,
                fmt"The word {w} was used before being defined."
            )

    of nkOp:
        p.evalOp(node.opV, node.opStr)


proc evalAll*(p: Program) =
    for i in p.ast:
        p.eval( i )