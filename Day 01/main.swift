//
//  main.swift
//  Day 01
//
//  Created by Stephen H. Gerstacker on 2020-12-01.
//

import Foundation

let data = Input.sorted()

var keepGoing = true

for (lhsIdx, lhs) in data.enumerated() {
    for (rhsIdx, rhs) in data.enumerated() {
        if lhsIdx == rhsIdx {
            continue
        }

        let sum = lhs + rhs

        if sum == 2020 {
            let result = lhs * rhs
            print("Part 1: \(result)")
            keepGoing = false
            break
        } else if sum > 2020 {
            break
        }
    }

    if !keepGoing {
        break
    }
}

keepGoing = true

for (oneIdx, one) in data.enumerated() {
    for (twoIdx, two) in data.enumerated() {
        for (threeIdx, three) in data.enumerated() {
            if oneIdx == twoIdx || twoIdx == threeIdx || oneIdx == threeIdx {
                continue
            }

            let sum = one + two + three

            if sum == 2020 {
                let result = one * two * three
                print("Part 2: \(result)")
                keepGoing = false
                break
            } else if sum > 2020 {
                break
            }
        }

        if !keepGoing {
            break
        }
    }

    if !keepGoing {
        break
    }
}
