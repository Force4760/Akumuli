###########################################################
## Calculator                                            ##
## - - - - - - - - - - - - - - - - - - - - - - - - - - - ##
## Input, Output, Stack, Alt Stack, Ints, Floats         ##
###########################################################

# Takes a value as an argument
# Checks if it is equal to the top value of the alt stack
# (Without consuming that stack value)
# (x)+(y) -b-> (x.y)+(_) -d-> (x.y.y)+(_) -c-> (x.y)+(y) -e-> (x==y)+(y)
@ is
  back dup cross eq
;

# Get the first value
'' ':' 'A' echo input toF

# Get the second value
'' ':' 'B' echo input toF

# Get operation to the alt stk
'' ':' 'p' 'O' echo input cross

'+' is if
  add
else '-' is if
  swap sub
else '*' is if
  mul
else '/' is if
  swap div
;;;;

print