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

- [ ] Add quit/end command
- [ ] Add way to auto push to alt stack
- [ ] Add fst, snd and trd inside words