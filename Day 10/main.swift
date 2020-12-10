//
//  main.swift
//  Day 10
//
//  Created by Stephen H. Gerstacker on 2020-12-10.
//

import Foundation

let data = Input

var joltages = data.split(separator: "\n").map { Int($0)! }.sorted()
joltages.insert(0, at: 0)
joltages.append(joltages.max()! + 3)

// MARK: - Part 1

var diffs: [Int] = []
var sums: [Int] = Array(repeating: 0, count: 4)

for (idx, value) in joltages.enumerated() {
    let diff: Int

    if idx == 0 {
        diff = value
    } else {
        diff = value - joltages[idx - 1]
    }

    sums[diff] += 1
}

print("Diffs: \(diffs)")
print("Sums: \(sums)")
print("Answer: \(sums[1] * sums[3])")

// MARK: - Part 2

var cache: [Int:Int] = [:]

func visit(idx: Int) -> Int {
    if idx == joltages.count - 1 {
        return 1
    }

    if let cached = cache[idx] {
        return cached
    }

    var result = 0

    let range = (idx + 1) ..< joltages.count

    for nextIdx in range {
        if joltages[nextIdx] - joltages[idx] <= 3 {
            result += visit(idx: nextIdx)
        }
    }

    cache[idx] = result

    return result
}


let total = visit(idx: 0)
print("Total Matches: \(total)")
