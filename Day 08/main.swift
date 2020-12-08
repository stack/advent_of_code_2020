//
//  main.swift
//  Day 08
//
//  Created by Stephen H. Gerstacker on 2020-12-08.
//

import Foundation

let data = Input

enum Operation {
    case acc(Int)
    case jmp(Int)
    case nop

    static func parse<T: StringProtocol>(_ line: T) -> Operation {
        let parts = line.split(separator: " ")

        guard parts.count == 2 else { fatalError("Invalid operation") }
        guard let value = Int(parts[1]) else { fatalError("Invalid value") }

        switch parts[0] {
        case "acc":
            return .acc(value)
        case "jmp":
            return .jmp(value)
        case "nop":
            return .nop
        default:
            fatalError("Unhandled operation: \(parts[0])")
        }
    }
}

class Computer {

    var accumulator: Int = 0
    var operations: [Operation] = []
    var head: Int = 0

    func parse<T: StringProtocol>(_ line: T) {
        let operation = Operation.parse(line)
        operations.append(operation)
    }

    func run() {
        accumulator = 0
        head = 0

        var previousHeads: Set<Int> = []

        while !previousHeads.contains(head) {
            previousHeads.insert(head)

            let operation = operations[head]
            switch operation {
            case .acc(let x):
                accumulator += x
                head += 1
            case .jmp(let x):
                head += x
            case .nop:
                head += 1
            }
        }
    }
}

let computer = Computer()

for line in data.split(separator: "\n") {
    computer.parse(line)
}

computer.run()
print("Value: \(computer.accumulator)")
