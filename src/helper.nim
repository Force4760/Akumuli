import re

iterator reverse*(s: string): char =
    ## Iterate through a string in reverse
    ## "name"    -> 'e' + 'm' + 'a' + 'n'
    ## "test it" -> 't' + 'i' + ' ' + 't' 's' 'e' 't'
    var i = len(s) - 1
    while i >= 0:
        yield s[i]
        dec i


func floatTobool*(f: float): bool =
    ## Convert a float into a bool
    ## 0 -> false | Inf -> false | _ -> true
    if f == 0.0 or f == Inf:
        return false
    return true


func toLower*(c: char): char =
    ## Convert a character to a lower version
    ## A -> a | B -> b | ...
    if c >= 'A' and c <= 'Z':
        return char( int(c) + 32 )
    return c


func toUpper*(c: char): char =
    ## Convert a character to an upper version
    ## a -> A | b -> B | ...
    if c >= 'a' and c <= 'z':
        return char( int(c) - 32 )
    return c


## Regex
func isAnInt* (s: string): bool = match(s, re"^-?\d+$")
func isAFloat*(s: string): bool = match(s, re"^-?\d+.\d+$")
func isAChar* (s: string): bool = match(s, re"^'[^']'$")
func isValid* (s: string): bool = match(s, re"^[A-z]+$")


## Colorize strings
func colorGreen*(s: string): string = "\e[0;32m" & s & "\e[0m"
func colorError*(s: string): string = "\e[0;31m" & s & "\e[0m"
func colorPrple*(s: string): string = "\e[0;35m" & s & "\e[0m"