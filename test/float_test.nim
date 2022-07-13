import unittest

import value

iterator range(x: float, y: float): float =
    var i = x
    while i < y:
        yield i
        i += 0.1

iterator testFloat(x: float = -10.0, y: float = 10.0): (float, float) =
    for i in range(x, y):
        for j in range(x, y):
            yield (i, j)

test "Add":
    for i, j in testFloat():
        require getF( new(i) + new(j) ) == i + j

test "Sub":
    for i, j in testFloat():
        require getF( new(i) - new(j) ) == i - j

test "Mul":
    for i, j in testFloat():
        require getF( new(i) * new(j) ) == i * j

test "Div":
    for i, j in testFloat():
        require getF( new(i) / new(j) ) == i / j

test "Inc":
    for i in range(-10, 10):
        require getF( ++new(i) ) == i + 1.0

test "Dec":
    for i in range(-10, 10):
        require getF( --new(i) ) == i - 1.0

test "Min":
    for i, j in testFloat():
        require getF( min( new(i), new(j) ) ) == min(i, j)

test "Max":
    for i, j in testFloat():
        require getF( max( new(i), new(j) ) ) == max(i, j)

test "Lesser":
    for i, j in testFloat():
        require getB( new(i) < new(j) ) == (i < j)

test "Greater":
    for i, j in testFloat():
        require getB( new(i) > new(j) ) == (i > j)

test "Lesser or equal":
    for i, j in testFloat():
        require getB( new(i) <= new(j) ) == (i <= j)

test "Greater or equal":
    for i, j in testFloat():
        require getB( new(i) >= new(j) ) == (i >= j)

test "Equal":
    for i, j in testFloat():
        require getB( new(i) == new(j) ) == (i == j)

test "Not Equal":
    for i, j in testFloat():
        require getB( new(i) != new(j) ) == (i != j)