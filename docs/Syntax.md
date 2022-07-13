# Syntax


## If Statements

```
if <if-body> ;
```

```
if <if-body> else <else-body>;
```

An `if-statement` is a control flow structure that allows you to conditionaly execute a sequence of statements.

When the interpreter finds an if, it will pop the top value of the stcak (a Bool) and check it for truthness. If it evaluates to `true`, the `if-body` will be executed, and if it evaluates to `false` and there is an `if-body` it will be the one that is executed.


## Loops

### For Loops

```
for <body> ;
```

A `for` is a control flow structure that will execute the `body` a certain number of times.

When the interpreter finds a for, it will pop the top value of the stack (an Int) and execute the body that number of times. There's a special variable that can be used inside for loops, called with `i`, that represents the number of repetitions it already finished.

### Ever Loops

```
ever <body> ;
```

An `ever` is a control flow structure that will execute the `body` until the program stops. It can be used to create a main loop.

### While Loops

```
while <body> ;
```

A `while` is a control flow structure that will execute the `body` until the stack is empty.


## Word Definition

```
@ <word> <body> ;
```

A `word` is simply an alias for a sequence of instructions. It can be used anywhere in the program after the definition and it will evaluate th body of the word with the current state of the stack.