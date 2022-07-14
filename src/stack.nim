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


proc len*[T](s: Stk[T]): int =
    ## Get the number of elements contained within the stack
    s.stk.len()


proc mustHave*[T](s: Stk[T], n: int) =
    ## Ensure the Stk has enought (n) elements for a certain operation
    ## Throws an IndexError exception if it doesn't
    if s.len() < n: raise IndexDefect.newException(
        "Can't use an operation because the stack doesn't have enought elements."
    )


proc pop*[T](s: Stk[T]): T =
    ## Remove and return the top element of the stack
    s.mustHave(1)
    return s.stk.pop()


proc popNoCheck[T](s: Stk[T]): T =
    ## Remove and return the top element of the stack
    ## Does not check if the stack has enough elements
    return s.stk.pop()


proc peek*[T](s: Stk[T]): T =
    ## Return the top element of the stack without removing it
    let a = s.stk.pop()
    s.stk.add(a)
    return a


proc push*[T](s: Stk[T], v: T) =
    ## Add a new value (v) to the stack
    s.stk.add(v)


proc dup*[T](s: Stk[T]) =
    ## ...|a -> ...|a|a
    s.mustHave(1)

    let a = s.popNoCheck()

    s.push(a); s.push(a)


proc dup2*[T](s: Stk[T]) =
    ## ...|b|a -> ...|b|a|b|a
    s.mustHave(2)

    let a = s.popNoCheck()
    let b = s.popNoCheck()

    s.push(b); s.push(a)
    s.push(b); s.push(a)


proc drop*[T](s: Stk[T]) =
    ## ...|b|a -> ...|b
    s.mustHave(1)
    let _ = s.popNoCheck()


proc swap*[T](s: Stk[T]) =
    ## ...|b|a -> ...|a|b
    s.mustHave(2)

    let a = s.popNoCheck()
    let b = s.popNoCheck()

    s.push(a); s.push(b)


proc over*[T](s: Stk[T]) =
    ## ...|b|a -> ...|b|a|b
    s.mustHave(2)

    let a = s.popNoCheck()
    let b = s.popNoCheck()

    s.push(b); s.push(a); s.push(b)


proc rot*[T](s: Stk[T]) =
    ## ...|c|b|a -> ...|b|a|c
    s.mustHave(3)

    let a = s.popNoCheck()
    let b = s.popNoCheck()
    let c = s.popNoCheck()

    s.push(b); s.push(a); s.push(c)


proc size*[T](s: Stk[T], f: int -> T) =
    ## ...|b|a -> ...|b|a|len
    ## f is a conversion function from integer to the type T
    s.push( f( s.len() ) )


proc `==`*[T](s, t: Stk[T]): bool =
    ## Compare two stacks
    s.stk == t.stk