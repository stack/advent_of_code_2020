//
//  main.swift
//  Day 10
//
//  Created by Stephen H. Gerstacker on 2020-12-10.
//

import Foundation

let data = Input

let joltages = data.split(separator: "\n").map { Int($0)! }.sorted()

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

diffs.append(3)
sums[3] += 1

print("Diffs: \(diffs)")
print("Sums: \(sums)")
print("Answer: \(sums[1] * sums[3])")
