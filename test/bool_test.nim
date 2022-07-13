import unittest

import value

let t = new(true)
let f = new(false)

test "And (&&)":
    require getB( t && t ) == true
    require getB( t && f ) == false
    require getB( f && t ) == false
    require getB( f && f ) == false

test "Or (||)":
    require getB( t || t ) == true
    require getB( t || f ) == true
    require getB( f || t ) == true
    require getB( f || f ) == false

test "Or (||)":
    require getB( !t ) == false
    require getB( !f ) == true

test "Equal (<=>)":
     require getB( t == t ) == true
     require getB( t == f ) == false
     require getB( f == t ) == false
     require getB( f == f ) == true

test "Not Equal (xor)":
     require getB( t != t ) == false
     require getB( t != f ) == true
     require getB( f != t ) == true
     require getB( f != f ) == false