//
//  main.swift
//  Day 14
//
//  Created by Stephen H. Gerstacker on 2020-12-14.
//

import Foundation

let data = Input

class Computer {

    var memory: [UInt:UInt] = [:]
    var onesMask: UInt = .max
    var zerosMask: UInt = .max

    let maskRegex: NSRegularExpression
    let memRegex: NSRegularExpression

    var sum: UInt {
        return memory.values.reduce(0) { $0 + $1 }
    }

    init() {
        maskRegex = try! NSRegularExpression(pattern: "mask = (.+)", options: [])
        memRegex = try! NSRegularExpression(pattern: "mem\\[(\\d+)\\] = (.+)", options: [])
    }

    func run(program: String) {
        for line in program.split(separator: "\n") {
            step(String(line))
        }
    }

    private func step(_ line: String) {
        let range = NSRange(line.startIndex ..< line.endIndex, in: line)

        if let match = maskRegex.firstMatch(in: line, options: [], range: range) {
            let maskRange = match.range(at: 1)
            let maskStringRange = Range(maskRange, in: line)!
            let mask = String(line[maskStringRange])

            process(mask: mask)
        } else if let match = memRegex.firstMatch(in: line, options: [], range: range) {
            let addressRange = match.range(at: 1)
            let addressStringRange = Range(addressRange, in: line)!
            let address = UInt(line[addressStringRange])!

            let valueRange = match.range(at: 2)
            let valueStringRange = Range(valueRange, in: line)!
            let value = UInt(line[valueStringRange])!

            process(address: address, value: value)
        } else {
            fatalError("Could not match the line")
        }
    }

    private func process(address: UInt, value: UInt) {
        var newValue = value
        newValue |= onesMask
        newValue &= zerosMask

        memory[address] = newValue
    }

    private func process(mask: String) {
        var ones: UInt = 0
        var zeros: UInt = .max

        for (idx, bit) in mask.enumerated() {
            let shift = mask.count - idx - 1

            if bit == "1" {
                ones |= (1 << shift)
            } else if bit == "0" {
                zeros ^= (1 << shift)
            }
        }

        onesMask = ones
        zerosMask = zeros
    }
}

let computer = Computer()
computer.run(program: data)

print("Sum: \(computer.sum)")
