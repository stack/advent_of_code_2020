//
//  main.swift
//  Day 06
//
//  Created by Stephen H. Gerstacker on 2020-12-06.
//

import Foundation

let data = Input

struct Group {

    var yeses: Array<Int> = Array(repeating: 0, count: 26)
    var people: Int = 0

    var allCount: Int {
        return yeses.reduce(0) { $0 + ($1 == people ? 1 : 0) }
    }

    var count: Int {
        return yeses.reduce(0) { $0 + ($1 != 0 ? 1 : 0) }
    }

    mutating func injest<T: StringProtocol>(line: T) {
        let letters = Array(line)

        for letter in letters {
            guard let ascii = letter.asciiValue else { fatalError("Letter not ASCII") }

            let index = Int(ascii) - 97

            guard index >= 0 && index < 26 else { fatalError("ASCII out of bounds") }

            yeses[index] += 1
        }

        people += 1
    }
}

var currentGroup: Group? = Group()
var groups: [Group] = []

for line in data.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false) {
    if line.isEmpty {
        groups.append(currentGroup!)
        currentGroup = Group()
        continue
    }

    currentGroup?.injest(line: line)
}

groups.append(currentGroup!)
currentGroup = nil

for group in groups {
    print("Count: \(group.count), All Count: \(group.allCount)")
}

print()

let countSum = groups.reduce(0) { $0 + $1.count }
print("Count Sum: \(countSum)")

let allCountSum = groups.reduce(0) { $0 + $1.allCount }
print("All Count Sum: \(allCountSum)")
