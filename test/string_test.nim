import unittest

import value

test "Lower":
    require getC( lower(new('l')) ) == 'l'
    require getC( lower(new('L')) ) == 'l'
    require getC( lower(new('.')) ) == '.'

test "Upper":
    require getC( upper(new('u')) ) == 'U'
    require getC( upper(new('U')) ) == 'U'
    require getC( upper(new('.')) ) == '.'
