//
//  main.swift
//  Day 15
//
//  Created by Stephen H. Gerstacker on 2020-12-15.
//

import Foundation

let data = Inputs

class Memory {
    let input: String
    var spoken: [Int:[Int]] = [:]
    var turn: Int
    var latest: Int

    init(data: String) {
        input = data
        
        let values = data.split(separator: ",").map { Int($0)! }

        for (idx, value) in values.enumerated() {
            spoken[value] = [idx + 1]
        }

        turn = values.count
        latest = values.last!
    }

    func run() {
        while turn < 2020 {
            let previous = spoken[latest]!
            let next: Int

            if previous.count == 1 {
                next = 0
            } else {
                next = previous[previous.count - 1] - previous[previous.count - 2]
            }

            var turns = spoken[next] ?? []
            turns.append(turn + 1)

            spoken[next] = turns
            latest = next

            turn += 1

            print("Spoke \(next) on turn \(turn)")
        }

        print("\(input): \(latest)")
    }
}

for value in data {
    let memory = Memory(data: value)
    memory.run()
}
