//
//  main.swift
//  Day 15
//
//  Created by Stephen H. Gerstacker on 2020-12-15.
//

import Foundation

let data = Inputs
// let count = 2020
let count = 30000000

class Memory {
    let input: String
    var spoken: [Int:[Int]] = [:]
    var turn: Int
    var latest: Int
    let count: Int

    init(data: String, count: Int) {
        input = data
        self.count = count
        
        let values = data.split(separator: ",").map { Int($0)! }

        for (idx, value) in values.enumerated() {
            spoken[value] = [idx + 1]
        }

        turn = values.count
        latest = values.last!
    }

    func run() {
        print("Input: \(input)")

        while turn < count {
            let previous = spoken[latest]!
            let next: Int

            // print("Previous \(latest) -> \(previous)")

            if previous.count == 1 {
                next = 0
            } else {
                next = previous[1] - previous[0]
            }

            var turns = spoken[next] ?? []

            if turns.count == 2 {
                turns[0] = turns[1]
                turns[1] = turn + 1
            } else {
                turns.append(turn + 1)
            }

            spoken[next] = turns
            latest = next

            turn += 1

            // print("Spoke \(next) on turn \(turn)")
        }

        print("\(input): \(latest)")
    }
}

for value in data {
    let memory = Memory(data: value, count: count)
    memory.run()
}
