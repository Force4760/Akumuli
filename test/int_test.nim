import unittest

import value

iterator testInt(x: int = -10, y: int = 10): (int, int) =
    for i in x..y:
        for j in x..y:
            yield (i, j)


test "Add":
    for i, j in testInt():
        require getI( new(i) + new(j) ) == i + j

test "Sub":
    for i, j in testInt():
        require getI( new(i) - new(j) ) == i - j

test "Mul":
    for i, j in testInt():
        require getI( new(i) * new(j) ) == i * j

test "Div":
    for i, j in testInt(-10, -1):
        require getI( new(i) / new(j) ) == i div j

    for i, j in testInt(1, 10):
        require getI( new(i) / new(j) ) == i div j

test "Mod":
    for i, j in testInt(-10, -1):
        require getI( new(i) % new(j) ) == i mod j

    for i, j in testInt(1, 10):
        require getI( new(i) % new(j) ) == i mod j

test "Inc":
    for i in -10..10:
        require getI( ++new(i) ) == i + 1

test "Dec":
    for i in -10..10:
        require getI( --new(i) ) == i - 1

test "Min":
    for i, j in testInt():
        require getI( min( new(i), new(j) ) ) == min(i, j)

test "Max":
    for i, j in testInt():
        require getI( max( new(i), new(j) ) ) == max(i, j)

test "Lesser":
    for i, j in testInt():
        require getB( new(i) < new(j) ) == (i < j)

test "Greater":
    for i, j in testInt():
        require getB( new(i) > new(j) ) == (i > j)

test "Lesser or equal":
    for i, j in testInt():
        require getB( new(i) <= new(j) ) == (i <= j)

test "Greater or equal":
    for i, j in testInt():
        require getB( new(i) >= new(j) ) == (i >= j)

test "Equal":
    for i, j in testInt():
        require getB( new(i) == new(j) ) == (i == j)

test "Not Equal":
    for i, j in testInt():
        require getB( new(i) != new(j) ) == (i != j)