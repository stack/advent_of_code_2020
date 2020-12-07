//
//  main.swift
//  Day 07
//
//  Created by Stephen H. Gerstacker on 2020-12-07.
//

import Foundation

let data = Input

// MARK: - Data

struct Rule: CustomDebugStringConvertible {
    let color: String
    let amount: Int

    var debugDescription: String {
        return "\(amount) \(color)"
    }
}

struct Bag {
    let color: String
    let rules: [Rule]
}

// MARK: - Parsing

let bagRegex = try! NSRegularExpression(pattern: "(.+) bags contain (.+)", options: [])
let ruleRegex = try! NSRegularExpression(pattern: "(\\d+) ([^,.]+) bags?[.,]", options: [])

var bags: [String:Bag] = [:]

for line in data.split(separator: "\n") {
    let bagRange = NSRange(line.startIndex ..< line.endIndex, in: line)

    bagRegex.enumerateMatches(in: String(line), options: [], range: bagRange) { (match, _, stop) in
        guard let match = match else { fatalError("Failed to match bag with \"\(line)\"") }

        let colorRange = Range(match.range(at: 1), in: line)!
        let color = line[colorRange]

        var rules: [Rule] = []

        ruleRegex.enumerateMatches(in: String(line), options: [], range: match.range(at: 2), using: { (rulesMatch, _, stop) in
            guard let rulesMatch = rulesMatch else { fatalError("Failed to match rules with \"\(line)\"") }
            guard rulesMatch.numberOfRanges > 2 else { return }

            let countRange = Range(rulesMatch.range(at: 1), in: line)!
            guard let count = Int(line[countRange]) else { fatalError("Failed to parse rule count with \"\(line)\"") }

            let ruleColorRange = Range(rulesMatch.range(at: 2), in: line)!
            let ruleColor = line[ruleColorRange]

            let rule = Rule(color: String(ruleColor), amount: count)
            rules.append(rule)
        })

        let bag = Bag(color: String(color), rules: rules)
        bags[bag.color] = bag

        print("Bag: \(bag)")
    }
}

// MARK: - Part 1
var containedBy: [String:[String]] = [:]

for bag in bags.values {
    for rule in bag.rules {
        if containedBy[rule.color] == nil {
            containedBy[rule.color] = []
        }

        containedBy[rule.color]!.append(bag.color)
    }
}

var toVisit: [String] = containedBy["shiny gold"] ?? []
var valid: Set<String> = []

while !toVisit.isEmpty {
    let current = toVisit.removeFirst()

    guard !valid.contains(current) else { continue }

    valid.insert(current)

    if let more = containedBy[current] {
        toVisit.append(contentsOf: more)
    }
}

print("Valid: \(valid)")
print("Count: \(valid.count)")

// MARK: - Part 2

var toVisit2: [Bag] = [bags["shiny gold"]!]
var sum = 0

while !toVisit2.isEmpty {
    let current = toVisit2.removeFirst()

    for rule in current.rules {
        sum += rule.amount
        let nextBag = bags[rule.color]!

        for _ in 0 ..< rule.amount {
            toVisit2.append(nextBag)
        }
    }

    // print("Current State: \(toVisit2)")
    // print("Current Amount: \(sum)")
}

print("Total: \(sum)")

