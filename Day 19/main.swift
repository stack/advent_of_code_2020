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
    let values: [String]
    let infinite: Bool

    var debugDescription: String {
        return values.map { "\"\($0)\"" }.joined(separator: " | ")
    }
}

class Resolver {

    var rules: [Rule] = []
    var firstRuleMatches: Set<String> = []

    func add(rule: String, index: Int) {
        let newRule: Rule

        if rule.hasPrefix("\"") {
            let value = rule.replacingOccurrences(of: "\"", with: "")
            let staticRule = StaticRule(values: [value], infinite: false)
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

    func resolve(patched: Bool = false) {
        if patched {
            rules[8] = ConditionalRule(parts: [[42], [42, 8]])
            rules[11] = ConditionalRule(parts: [[42,31], [42, 11, 3]])
        }
        
        for idx in 0 ..< rules.count {
            if rules[idx] is EmptyRule {
            } else {
                resolve(idx: idx)
            }
        }

        let firstRule = rules[0] as! StaticRule
        firstRuleMatches = Set(firstRule.values)
    }

    func firstMatch(line: String) -> Int? {
        if firstRuleMatches.contains(line) {
            return 0
        }

        return nil
    }

    @discardableResult private func resolve(idx: Int) -> StaticRule {
        if let staticRule = rules[idx] as? StaticRule {
            return staticRule
        } else if let conditionalRule = rules[idx] as? ConditionalRule {
            var values: [String] = []

            // "2 3 | 3 2"
            for part in conditionalRule.parts {
                // "2 3"
                let resolved = part.map { resolve(idx: $0) }
                let results = generate(rules: resolved)

                values.append(contentsOf: results)
            }

            let rule = StaticRule(values: values, infinite: false)
            rules[idx] = rule

            return rule
        } else {
            fatalError("Cannot resolve empty rule")
        }
    }

    private func generate(rules: [StaticRule], ruleIdx: Int = 0, current: [String] = []) -> [String] {
        guard ruleIdx < rules.count else {
            return current
        }

        let currentRule = rules[ruleIdx]
        var next: [String] = []

        if current.isEmpty {
            next.append(contentsOf: currentRule.values)
        } else {
            for currentValue in current {
                for value in currentRule.values {
                    next.append(currentValue + value)
                }
            }
        }

        return generate(rules: rules, ruleIdx: ruleIdx + 1, current: next)
    }

    func printRules() {
        for (idx, rule) in rules.enumerated() {
            print("\(idx): \(rule)")
        }
    }
}

let ruleRegex = try! NSRegularExpression(pattern: "(\\d+): (.+)", options: [])

let resolver = Resolver()
var toTest: [String] = []

for line in data.split(separator: "\n") {
    let lineString = String(line)
    let range = NSRange(lineString.startIndex ..< lineString.endIndex, in: lineString)

    if let match = ruleRegex.firstMatch(in: lineString, options: [], range: range) {
        let indexRange = Range(match.range(at: 1), in: lineString)!
        let index = Int(lineString[indexRange])!

        let ruleRange = Range(match.range(at: 2), in: lineString)!
        let rule = String(lineString[ruleRange])

        resolver.add(rule: rule, index: index)
    } else {
        toTest.append(lineString)
    }
}

print("Before resolution:")
resolver.printRules()

resolver.resolve()

print()
print("After resolution:")
// resolver.printRules()

let matches = toTest.compactMap { (line: String) -> Int? in
    let result = resolver.firstMatch(line: line)

    print("\(line) matches \(String(describing: result))")

    return result
}

let matches0 = matches.filter { $0 == 0 }
print("Matches 0: \(matches0.count)")
