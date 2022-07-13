import unittest, sugar

import stack

test "Pop":
    let s = toStk(@[1, 2, 3, 4])
    let a = s.pop()

    require a  == 4
    require s == @[1, 2, 3].toStk

test "Push":
    let s = toStk(@[1, 2, 3, 4])
    s.push(5)

    require s == @[1, 2, 3, 4, 5].toStk

test "Len":
    let s = toStk(@[1, 2, 3, 4])

    require s.len() == 4

test "Dup":
    let s = toStk(@[1, 2, 3, 4])
    s.dup()

    require s == @[1, 2, 3, 4, 4].toStk

test "Dup2":
    let s = toStk(@[1, 2, 3, 4])
    s.dup2()

    require s == @[1, 2, 3, 4, 3, 4].toStk

test "Drop":
    let s = toStk(@[1, 2, 3, 4])
    s.drop()

    require s == @[1, 2, 3].toStk

test "Swap":
    let s = toStk(@[1, 2, 3, 4])
    s.swap()

    require s == @[1, 2, 4, 3].toStk

test "Over":
    let s = toStk(@[1, 2, 3, 4])
    s.over()

    require s == @[1, 2, 3, 4, 3].toStk

test "Rot":
    let s = toStk(@[1, 2, 3, 4])
    s.rot()

    require s == @[1, 3, 4, 2].toStk

test "Size":
    let s = toStk(@[1, 2, 3, 4])
    s.size((x) => x)

    require s == @[1, 2, 3, 4, 4].toStk