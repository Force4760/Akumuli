import strutils
import lexer, parser, interpret, helper


proc ctrlc() {.noconv.} =
    quit( colorError("\nInterupted by Ctrl+C\n"), 0 )


proc loadFile(path: string): string =
    ## Open the file and close it at the end of the proc
    let f = readFile(path)

    for i in f.split('\n'):
        if not i.strip().startsWith("#"):
            result &= i & "\n"


proc runProg(src: string) =
    ## Lexer: src -> Tokens
    let lex = newLexer(src)
    let toks = lex.tokenize()

    ## Parser: Tokens -> Ast
    let par = newParser(toks)
    let ast = par.parse()

    ## Evaluate: Ast -> output
    let prog = newProgram(ast)
    prog.evalAll()


proc akumuliMain(path: string) =
    try:
        let src = loadFile( path )
        runProg( src )
    except Exception as e:
        echo colorError( "Error: " & e.msg )

when isMainModule:
    import cligen
    setControlCHook(ctrlc)
    dispatch akumuliMain