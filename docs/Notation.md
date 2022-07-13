# Notation

In the docs ( Readme ), I'll be using some notation to simplify things. This document serves as an explanation of that notation


## Type notations

```sh
# A function that takes two Integers and returns an Integer
I² → I

# A function that takes either an Integer, a Boolean or a Float and returns an Character
I|B|F → C
```

* `I`: Integer
* `F`: Float
* `B`: Boolean
* `C`: Character
* `()`: Unit Type (void in C and C++)
* `T`: Generic type
* `T²`: A tupple containing two values of the T type, `T² == (T, T)`
* `|`: Choice of types, `I|B` is the same as `either I or B`
* `→`: A function between types
* `[T]`: A sequence of values of type T

## Stack Notation

```sh
# A stack with `a` at the top, `b` as the second value and `c` as the last one
# Bottom ... Top
(c . b . a)

# Two stacks
(d . c . b . a) + (x . y)

# Empty stack
(_)
```