//
//  main.swift
//  Day 09
//
//  Created by Stephen H. Gerstacker on 2020-12-09.
//

import Foundation

let data = Input
let preamble = InputPreamble

let numbers = data.split(separator: "\n").map { Int($0)! }

// MARK: - Part 1

var searchSpace = numbers
var firstInvalid: Int = -1

while searchSpace.count > preamble {
    let value = searchSpace[preamble]
    let previousNumbers = searchSpace[0 ..< preamble]

    var isValid = false

    for number in previousNumbers {
        let diff = abs(value - number)

        if previousNumbers.contains(diff) {
            isValid = true
            break
        }
    }

    if !isValid {
        firstInvalid = value
        break
    }

    searchSpace.removeFirst()
}

print("First Invalid: \(firstInvalid)")

// MARK: - Part 2

var index = 0
var size = 2

var lhs = -1
var rhs = -1

while true {
    let range = index ..< (index + size)
    let sum = numbers[range].reduce(0) { $0 + $1 }

    if sum < firstInvalid {
        size += 1
    } else if sum > firstInvalid {
        index += 1
        size = 2
    } else {
        lhs = numbers[range].min()!
        rhs = numbers[range].max()!
        break
    }
}

print("Weakness: \(lhs) + \(rhs) = \(lhs + rhs)")
