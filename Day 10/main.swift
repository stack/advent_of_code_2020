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

// MARK: - Part 2

let targetJoltage = joltages.last! + 3
var matches: [[Int]] = []

func visit(visited: [Int], remaining: [Int]) {
    if (remaining.isEmpty) {
        // print("* Match: \(visited)")
        matches.append(visited)
        return
    }

    let currentJoltage = visited.last ?? 0

    // print("- (\(currentJoltage)): \(visited) - \(remaining)")

    var invalidIndexes: [Int] = []
    var nextIndexes: [Int] = []

    for (idx, value) in remaining.enumerated() {
        let diff = value - currentJoltage

        if diff <= 0 {
            invalidIndexes.append(idx)
        } else if diff <= 3 {
            nextIndexes.append(idx)
        } else {
            break
        }
    }

    for index in nextIndexes {
        var nextVisited = visited
        var nextRemaining = remaining

        nextVisited.append(nextRemaining.remove(at: index))
        nextRemaining = nextRemaining.filter { $0 > nextVisited.last! }

        visit(visited: nextVisited, remaining: nextRemaining)
    }
}

visit(visited: [], remaining: joltages)
print("Total Matches: \(matches.count)")
