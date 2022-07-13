import strutils, sequtils, sugar
import tokens

type
    NodeKind* = enum
        nkIf, nkWord,
        nkFor, nkEver, nkWhile,
        nkI, nkF, nkB, nkC,
        nkOp, nkUk

    Node* = object
        case kind*: NodeKind:
        of nkIf:
            ifV*  : seq[Node]
            elseV*: seq[Node]
        of nkFor:
            forV*: seq[Node]
        of nkEver:
            everV*: seq[Node]
        of nkWhile:
            whileV*: seq[Node]
        of nkWord:
            word* : string
            wordV*: seq[Node]
        of nkI:
            iV*: int
        of nkF:
            fV*: float
        of nkB:
            bV*: bool
        of nkC:
            cV*: char
        of nkOp:
            opV*  : TokenKind
            opStr*: string
        of nkUk:
            ukV*: string


## Constructors
func newIf*(i, e: seq[Node]): Node =
    Node(kind: nkIf, ifV: i, elseV: e)

func newFor*(f: seq[Node]): Node =
    Node(kind: nkFor, forV: f)

func newEver*(e: seq[Node]): Node =
    Node(kind: nkEver, everV: e)

func newWhile*(w: seq[Node]): Node =
    Node(kind: nkWhile, whileV: w)

func newWord*(w: string, b: seq[Node]): Node =
    Node(kind: nkWord, word: w, wordV: b)

func newI*(i: int): Node =
    Node(kind: nkI, iV: i)

func newF*(f: float): Node =
    Node(kind: nkF, fV: f)

func newB*(b: bool): Node =
    Node(kind: nkB, bV: b)

func newC*(c: char): Node =
    Node(kind: nkC, cV: c)

func newOp*(o: TokenKind, s: string): Node =
    Node(kind: nkOp, opV: o, opStr: s)

func newUk*(uk: string): Node =
    Node(kind: nkUk, ukV: uk)


## String representation
func str*(ns: seq[Node], f: Node -> string): string =
    ns.map(f).join("")

func `$`*(n: Node): string =
    case n.kind:
    of nkUk: n.ukV & " "
    of nkOp: ($n.opV)[1..^1] & " "
    of nkC: $n.cV & " "
    of nkB: $n.bV & " "
    of nkF: $n.fV & " "
    of nkI: $n.iV & " "
    of nkWord : "@ "     & n.word & " " & n.wordV.str(`$`)             & ";\n"
    of nkFor  : "for "   & n.forV.str(`$`)                             & ";\n"
    of nkEver : "ever "  & n.everV.str(`$`)                            & ";\n"
    of nkWhile: "while " & n.everV.str(`$`)                            & ";\n"
    of nkIf   : "if "    & n.ifV.str(`$`) & "else " & n.elseV.str(`$`) & ";\n"

