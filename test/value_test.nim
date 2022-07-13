import unittest

import value

test "String representation":
    require $new(1) == "\e[0;32mInt(1)\e[0m"
    require $new(1.10) == "\e[0;32mFloat(1.1)\e[0m"
    require $new(true) == "\e[0;32mBool(true)\e[0m"
    require $new(false) == "\e[0;32mBool(false)\e[0m"
    require $new('t') == "\e[0;32mChar(t)\e[0m"

test "String representation":
    require getStr( new(1)      ) == "1"
    require getStr( new(1.10)   ) == "1.1"
    require getStr( new(true)   ) == "true"
    require getStr( new(false)  ) == "false"
    require getStr( new('t') ) == "t"

test "Checkers - Is":
    require isI( new(1)    ) == true
    require isI( new(1.0)  ) == false
    require isI( new(true) ) == false
    require isI( new('t')  )  == false

    require isF( new(1)    ) == false
    require isF( new(1.0)  ) == true
    require isF( new(true) ) == false
    require isF( new('t')  ) == false

    require isB( new(1)    ) == false
    require isB( new(1.0)  ) == false
    require isB( new(true) ) == true
    require isB( new('t')  ) == false

    require isC( new(1)    ) == false
    require isC( new(1.0)  ) == false
    require isC( new(true) ) == false
    require isC( new('t')  ) == true

test "Checkers - Both":
    require bothI( new(1)   , new(1)    ) == true
    require bothI( new(1.0) , new(1.0)  ) == false
    require bothI( new(true), new(true) ) == false
    require bothI( new('t') , new('t')  ) == false

    require bothF( new(1)   , new(1)    ) == false
    require bothF( new(1.0) , new(1.0)  ) == true
    require bothF( new(true), new(true) ) == false
    require bothF( new('t') , new('t')  ) == false

    require bothB( new(1)   , new(1)    ) == false
    require bothB( new(1.0) , new(1.0)  ) == false
    require bothB( new(true), new(true) ) == true
    require bothB( new('t') , new('t')  ) == false

    require bothC( new(1)   , new(1)    ) == false
    require bothC( new(1.0) , new(1.0)  ) == false
    require bothC( new(true), new(true) ) == false
    require bothC( new('t') , new('t')  ) == true

test "Getters":
    require getI( new(1)    ) == 1
    require getF( new(1.0)  ) == 1.0
    require getB( new(true) ) == true
    require getC( new('t')  ) == 't'

test "Converter":
    require getI( toI new(1.5)  ) == 1
    require getI( toI new(true) ) == 1
    require getI( toI new('t')  ) == 116

    require getF( toF new(2)    ) == 2.0
    require getF( toF new(true) ) == 1.0
    require getF( toF new('t')  ) == 116.0

    require getB( toB new(2)   ) == true
    require getB( toB new(0)   ) == false
    require getB( toB new(1/0) ) == false
    require getB( toB new(1.0) ) == true
    require getB( toB new(0.0) ) == false
    require getB( toB new('t') ) == true
    require getB( toB new(' ') ) == false

    require getC( toC new(116)     ) == 't'