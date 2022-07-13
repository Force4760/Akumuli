###########################################################
## Factorial Program                                     ##
## - - - - - - - - - - - - - - - - - - - - - - - - - - - ##
## Input, Output, looping and words as functions         ##
###########################################################

# factorial function
# Receives an integer as argument
@ fact
  1 swap
  for
    i 1 add
    mul
  ;
;

# Prompt for a number with "Number: "
'' ':' 'r' 'e' 'b' 'm' 'u' 'N' echo input

# Response "Factorial: "
'' ':' 'l' 'a' 'i' 'r' 'o' 't' 'c' 'a' 'F' echo

# Calculate and print the factorial
fact print