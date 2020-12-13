//
//  main.swift
//  Day 13
//
//  Created by Stephen H. Gerstacker on 2020-12-13.
//

import Foundation

let data = Example
let lines = data.split(separator: "\n")


// MARK: - Part 1

let timestamp = Int(lines[0])!
let ids = lines[1].split(separator: ",").compactMap { Int($0) }

var currentTimestamp = timestamp
var departs = ids.map { currentTimestamp % $0 == 0 }

while !departs.contains(true) {
    currentTimestamp += 1
    departs = ids.map { currentTimestamp % $0 == 0 }
}

print("Part 1:")

print("Depart time: \(currentTimestamp)")

let waitTime = currentTimestamp - timestamp
print("Wait time: \(waitTime)")

let selectedIdx = departs.firstIndex(of: true)!
let selectedId = ids[selectedIdx]

let value = waitTime * selectedId
print("Answer 1: \(value)")
print()


// MARK: - Part 2

let dataList = Inputs

for data in dataList {
    print("Running \(data)")

    let busIdStrings = data.split(separator: ",")
    let allBusIds = busIdStrings.map { Int($0) ?? 0 }

    let busIds: [Int] = allBusIds.filter { $0 != 0 }.sorted().reversed()
    let offsets: [Int] = busIds.map { allBusIds.firstIndex(of: $0)! }

    var step = 1
    var count = 1
    currentTimestamp = 0

    while count <= busIds.count {
        var found = true

        for idx in 0 ..< count {
            let timestamp = currentTimestamp + offsets[idx]
            let departed = timestamp % busIds[idx] == 0

            if !departed {
                found = false
                break
            }
        }

        if found {
            print("Found match for first \(count) with \(currentTimestamp)")
            step *= busIds[count - 1]
            count += 1
        } else {
            currentTimestamp += step
        }
    }
}
