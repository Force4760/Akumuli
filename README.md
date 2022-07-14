# Akumuli

Stack oriented programming language inspired by `forth` written in `nim`


## Interpreter Pipeline

```
                 +-------+
( src )   --->   | Lexer |   --->   ( Token )
                 +-------+
                                        |
                                        v

                                    +--------+
                    ( Ast )   <---  | Parser |
                                    +--------+
                       |
                       v

                  +----------+
( Input )  ---->  | Evaluate |  --->  ( Output )
                  +----------+
```

## Todo

- [ ] Add way to auto push to alt stack