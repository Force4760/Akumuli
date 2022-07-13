###########################################################
## Logic                                                 ##
## - - - - - - - - - - - - - - - - - - - - - - - - - - - ##
## Input, Output, Stack, Alt Stack, Bools                ##
###########################################################

# Takes a value as an argument
# Checks if it is equal to the top value of the alt stack
# (Without consuming that stack value)
# (x)+(y) -b-> (x.y)+(_) -d-> (x.y.y)+(_) -c-> (x.y)+(y) -e-> (x==y)+(y)
@ is
  back dup cross eq
;

# Get operation to the alt stk
'' ':' 'p' 'O' echo input cross

'~' is if
    '' ':' 'A' echo input toB
    not
else

    '' ':' 'A' echo input toB

    '' ':' 'B' echo input toB

    '^' is if
        and
    else 'v' is if
        or
    else '=' is if
        eq
    ;;;

;

print