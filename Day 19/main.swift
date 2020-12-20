//
//  main.swift
//  Day 19
//
//  Created by Stephen H. Gerstacker on 2020-12-19.
//

import Foundation

let data = Example2

protocol Rule: CustomDebugStringConvertible { }

struct ConditionalRule: Rule {
    let parts: [[Int]]

    var debugDescription: String {
        return parts.map { (part: [Int]) -> String in
            let subpart = part.map { String($0) }
            return subpart.joined(separator: " ")
        }.joined(separator: " | ")
    }
}

struct EmptyRule: Rule {

    var debugDescription: String {
        return "EMPTY"
    }
}

struct StaticRule: Rule {
    let value: String

    var debugDescription: String {
        return "\"\(value)\""
    }
}

let ruleRegex = try! NSRegularExpression(pattern: "(\\d+): (.+)", options: [])

class Visitor {
    var rules: [Rule] = []
    var tests: [String] = []

    func add(rule: String, index: Int) {
        let newRule: Rule

        if rule.hasPrefix("\"") {
            let value = rule.replacingOccurrences(of: "\"", with: "")
            let staticRule = StaticRule(value: value)
            newRule = staticRule
        } else {
            let parts = rule
                .split(separator: "|")
                .map {
                    $0.split(separator: " ").map { Int($0)! }
                }

            let conditionalRule = ConditionalRule(parts: parts)
            newRule = conditionalRule
        }

        while rules.count <= index {
            rules.append(EmptyRule())
        }

        rules[index] = newRule
    }

    func run() {
        // rules[8] = ConditionalRule(parts: [[42], [42, 8]])
        // rules[11] = ConditionalRule(parts: [[42, 31], [42, 11, 31]])

        var matches = 0

        for test in tests {
            // print("Testing \(test)")
            let possible = possibleValues(test: test, idx: 0)
            // print("Possible: \(possible)")
            // print("==========")

            if possible.contains(test) {
                matches += 1
            }
        }

        print("Matches: \(matches)")
    }

    func possibleValues(test: String, idx: Int, prior: String = "") -> [String] {
        // print("IDX: \(idx) -> \(prior)")

        let rule = rules[idx]

        switch rule {
        case let x as ConditionalRule:
            return possibleValues(test: test, rule: x, prior: prior)
        case let x as StaticRule:
            return possibleValues(test: test, rule: x, prior: prior)
        default:
            fatalError("Cannot get value")
        }
    }

    func possibleValues(test: String, rule: ConditionalRule, prior: String) -> [String] {
        // print("Cond -> \(prior)")

        var possible: [String] = []

        for part in rule.parts {
            var combos: [String] = []

            for idx in part {
                if combos.isEmpty {
                    combos = possibleValues(test: test, idx: idx, prior: prior)
                } else {
                    var nextCombos: [String] = []

                    for combo in combos {
                        let results = possibleValues(test: test, idx: idx, prior: prior + combo)

                        for result in results {
                            nextCombos.append(combo + result)
                        }
                    }

                    combos = nextCombos
                }
            }

            possible.append(contentsOf: combos)
        }

        return possible
    }

    func possibleValues(test: String, rule: StaticRule, prior: String) -> [String] {
        // print("Static -> \(prior)")

        if !prior.isEmpty {
            let next = prior + rule.value

            if !test.hasPrefix(next) {
                return []
            }
        }

        return [rule.value]
    }
}

let visitor = Visitor()

for line in data.split(separator: "\n") {
    let lineString = String(line)
    let range = NSRange(lineString.startIndex ..< lineString.endIndex, in: lineString)

    if let match = ruleRegex.firstMatch(in: lineString, options: [], range: range) {
        let indexRange = Range(match.range(at: 1), in: lineString)!
        let index = Int(lineString[indexRange])!

        let ruleRange = Range(match.range(at: 2), in: lineString)!
        let rule = String(lineString[ruleRange])

        visitor.add(rule: rule, index: index)
    } else {
        visitor.tests.append(lineString)
    }
}

visitor.run()
