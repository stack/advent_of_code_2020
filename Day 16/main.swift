//
//  main.swift
//  Day 16
//
//  Created by Stephen H. Gerstacker on 2020-12-16.
//

import Foundation

let data = Input

enum State {
    case rules
    case yourTicket
    case nearbyTickets
}

let ruleRegex = try! NSRegularExpression(pattern: "(\\w+): (\\d+)-(\\d+) or (\\d+)-(\\d+)", options: [])

var state = State.rules
var rules: [String:[ClosedRange<Int>]] = [:]
var yourTicket: [Int] = []
var nearbyTickets: [[Int]] = []

for line in data.split(separator: "\n") {
    switch state {
    case .rules:
        guard line != "your ticket:" else {
            state = .yourTicket
            continue
        }

        let range = NSRange(line.startIndex ..< line.endIndex, in: line)
        guard let match = ruleRegex.firstMatch(in: String(line), options: [], range: range) else {
            fatalError("Invalid rule match")
        }

        let ruleNameRange = match.range(at: 1)
        let ruleNameStringRange = Range(ruleNameRange, in: line)!
        let ruleName = line[ruleNameStringRange]

        let valid1LhsRange = match.range(at: 2)
        let valid1LhsStringRange = Range(valid1LhsRange, in: line)!
        let valid1Lhs = Int(line[valid1LhsStringRange])!

        let valid2LhsRange = match.range(at: 4)
        let valid2LhsStringRange = Range(valid2LhsRange, in: line)!
        let valid2Lhs = Int(line[valid2LhsStringRange])!

        let valid1RhsRange = match.range(at: 3)
        let valid1RhsStringRange = Range(valid1RhsRange, in: line)!
        let valid1Rhs = Int(line[valid1RhsStringRange])!

        let valid2RhsRange = match.range(at: 5)
        let valid2RhsStringRange = Range(valid2RhsRange, in: line)!
        let valid2Rhs = Int(line[valid2RhsStringRange])!

        rules[String(ruleName)] = [ (valid1Lhs ... valid1Rhs), (valid2Lhs ... valid2Rhs) ]
    case .yourTicket:
        guard line != "nearby tickets:" else {
            state = .nearbyTickets
            continue
        }

        yourTicket = line.split(separator: ",").map { Int($0)! }
    case .nearbyTickets:
        let result = line.split(separator: ",").map { Int($0)! }
        nearbyTickets.append(result)
    }
}

var errors: [Int] = []

for nearby in nearbyTickets {
    for value in nearby {
        var matched = false

        for (_, ranges) in rules {
            for range in ranges {
                if range.contains(value) {
                    matched = true
                    break
                }
            }

            if matched { break }
        }

        if !matched {
            errors.append(value)
        }
    }
}

let errorRate = errors.reduce(0, +)
print("Error rate: \(errorRate)")
