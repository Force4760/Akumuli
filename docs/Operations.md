## Operations

| Description           | KeyWord  | Type notation              |
| --------------------- | -------- | -------------------------- |
| Add                   | add      | I² → I or F² → F           |
| Subtract              | sub      | I² → I or F² → F           |
| Multiply              | mul      | I² → I or F² → F           |
| Divide                | div      | I² → I or F² → F           |
| Modulus               | mod      | I² → I                     |
| Minimum               | min      | I² → I or F² → F           |
| Maximum               | max      | I² → I or F² → F           |
| Increment             | inc      | I  → I or F → F            |
| Decrement             | dec      | I  → I or F → F            |
| Lesser than           | less     | I² → B or F² → B or C² → B |
| Greater than          | great    | I² → B or F² → B or C² → B |
| Lesser than or equal  | leq      | I² → B or F² → B or C² → B |
| Greater than or equal | geq      | I² → B or F² → B or C² → B |
| Equal                 | eq       | T² → B                     |
| Not Equal             | neq      | T² → B                     |
| And                   | and      | B² → B                     |
| Or                    | or       | B² → B                     |
| Not                   | not      | B  → B                     |
| Lower                 | lower    | C  → C                     |
| Is Integer            | isF      | T  → B                     |
| Is Float              | isF      | T  → B                     |
| Is Boolean            | isB      | T  → B                     |
| Is Character          | isC      | T  → B                     |
| Convert to Integer    | toI      | T  → I                     |
| Convert to Float      | toF      | T  → F                     |
| Convert to Boolean    | toB      | T  → B                     |
| Convert to Charcater  | toC      | I  → C or C → C            |
| Echo all character    | echo     | Cˣ → ()                    |
| Print a value         | print    | Tˣ → ()                    |
| Get Value from input  | input    | () → T                     |
| Get Chars from input  | inputStr | () → [C]                   |


## Stack Operations

| Description                | KeyWord  | Stack notation              |
| -------------------------- | -------- | --------------------------- |
| Duplicate the top elem     | dup      | (c.b.a) → (c.b.a.a)         |
| Duplicate the top 2 elems  | dup2     | (c.b.a) → (c.b.a.b.a)       |
| Drop the top elem          | drop     | (c.b.a) → (c.b)             |
| Swap the top 2 elems       | swap     | (c.b.a) → (c.a.b)           |
| Copy the top elem to top   | over     | (c.b.a) → (c.b.a.b)         |
| Rotate the top 3 elems     | rot      | (c.b.a) → (b.a.c)           |
| Push the size of the stk   | size     | (c.b.a) → (c.b.a.3)         |
| Pop the top to the alt stk | cross    | (c.b.a) + (_) → (c.b) + (a) |
| Push from the alt stk      | back     | (c.b) + (a) → (c.b.a) + (_) |

