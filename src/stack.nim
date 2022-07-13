import sugar

type Stk*[T] = ref object
    ## Stack LIFO Datastructure
    stk: seq[T]


proc toStk*[T](s: seq[T]): Stk[T] =
    ## Turn a seq into a Stk
    Stk[T](stk: s)


proc newStk*(T: typedesc): Stk[T] =
    ## Create a new stack
    Stk[T](stk: newSeq[T]())


proc pop*[T](s: Stk[T]): T =
    ## Remove and return the top element of the stack
    return s.stk.pop()


proc peek*[T](s: Stk[T]): T =
    ## Return the top element of the stack without removing it
    let a = s.stk.pop()
    s.stk.add(a)
    return a


proc push*[T](s: Stk[T], v: T) =
    ## Add a new value (v) to the stack
    s.stk.add(v)


proc len*[T](s: Stk[T]): int =
    ## Get the number of elements contained within the stack
    s.stk.len()


proc dup*[T](s: Stk[T]) =
    ## ...|a -> ...|a|a
    let a = s.pop()

    s.push(a); s.push(a)


proc dup2*[T](s: Stk[T]) =
    ## ...|b|a -> ...|b|a|b|a
    let a = s.pop()
    let b = s.pop()

    s.push(b); s.push(a)
    s.push(b); s.push(a)


proc drop*[T](s: Stk[T]) =
    ## ...|b|a -> ...|b
    let _ = s.pop()


proc swap*[T](s: Stk[T]) =
    ## ...|b|a -> ...|a|b
    let a = s.pop()
    let b = s.pop()

    s.push(a); s.push(b)


proc over*[T](s: Stk[T]) =
    ## ...|b|a -> ...|b|a|b
    let a = s.pop()
    let b = s.pop()

    s.push(b); s.push(a); s.push(b)


proc rot*[T](s: Stk[T]) =
    ## ...|c|b|a -> ...|b|a|c
    let a = s.pop()
    let b = s.pop()
    let c = s.pop()

    s.push(b); s.push(a); s.push(c)


proc size*[T](s: Stk[T], f: int -> T) =
    ## ...|b|a -> ...|b|a|len
    ## f is a conversion function from integer to the type T
    s.push( f( s.len() ) )


proc `==`*[T](s, t: Stk[T]): bool =
    ## Compare two stacks
    s.stk == t.stk