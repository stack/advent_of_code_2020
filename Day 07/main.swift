//
//  main.swift
//  Day 07
//
//  Created by Stephen H. Gerstacker on 2020-12-07.
//

import Foundation

let data = Input

struct Rule {
    let color: String
    let amount: Int
}

struct Bag {
    let color: String
    let rules: [Rule]
}

let bagRegex = try! NSRegularExpression(pattern: "(.+) bags contain (.+)", options: [])
let ruleRegex = try! NSRegularExpression(pattern: "(\\d+) ([^,.]+) bags?[.,]", options: [])

var bags: [Bag] = []

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
        bags.append(bag)

        print("Bag: \(bag)")
    }
}

var containedBy: [String:[String]] = [:]

for bag in bags {
    for rule in bag.rules {
        if containedBy[rule.color] == nil {
            containedBy[rule.color] = []
        }

        containedBy[rule.color]!.append(bag.color)
    }
}

var toVisit: [String] = containedBy["shiny gold"]!
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
