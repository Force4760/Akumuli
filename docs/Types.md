# Types

Akumuli has 4 types: *Int*, *Float*, *Bool* and *Char*


## Int
Regex: `-?[0-9]+`
Ex: -19, 15, 111, 1, -234, 0


## Float
Regex: `-?[0-9]+.[0-9]+`
Ex: -19.1, 765.2, 0.23, 44.2


## Bool
true, false


## Char
Regex: `'.'|'\n'|'\t'|''`
Ex: '', ':', '1', 'w'

Note: To avoid confusion, `''` represents a space character, `' '` can't be used since it looks weird and could create confusion about spaces