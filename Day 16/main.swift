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

let ruleRegex = try! NSRegularExpression(pattern: "(.+): (\\d+)-(\\d+) or (\\d+)-(\\d+)", options: [])

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
var validTickets: [[Int]] = []

for nearby in nearbyTickets {
    var isValid = true

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
            isValid = false
        }
    }

    if isValid {
        validTickets.append(nearby)
    }
}

let errorRate = errors.reduce(0, +)
print("Error rate: \(errorRate)")

var exclusions = Array(repeating: Set<String>(), count: yourTicket.count)

for ticket in validTickets {
    for (idx, value) in ticket.enumerated() {
        for (rule, ranges) in rules {
            let matches = ranges.reduce(false) { $0 || $1.contains(value) }

            if (!matches) {
                exclusions[idx].insert(rule)
            }
        }
    }
}

print("Exclusions: \(exclusions)")

var solved = 0
var columns = Array(repeating: "", count: yourTicket.count)
let allKeys = Set(rules.keys)

while solved < yourTicket.count {
    var found: String? = nil

    for (idx, exclusion) in exclusions.enumerated() {
        guard exclusion.count == allKeys.count - 1  else {
            continue
        }

        let missing = allKeys.subtracting(exclusion)

        precondition(missing.count == 1)
        let result = missing.first!

        print("Index \(idx) is missing \(result)")

        columns[idx] = result
        solved += 1

        print("Columns: \(columns)")

        found = result

        break
    }

    guard let toAdd = found else {
        fatalError("Failed to find a match")
    }

    for idx in 0 ..< exclusions.count {
        exclusions[idx].insert(toAdd)
    }
}

var answer = 1

for (idx, value) in yourTicket.enumerated() {
    let key = columns[idx]

    if key.contains("departure") {
        print("Column \(idx) is \"\(key)\" -> \(value)")
        answer *= value
    }
}

print("Result: \(answer)")
