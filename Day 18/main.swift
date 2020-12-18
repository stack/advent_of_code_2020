//
//  main.swift
//  Day 18
//
//  Created by Stephen H. Gerstacker on 2020-12-18.
//

import Foundation

let data = Inputs

enum Token: CustomDebugStringConvertible {
    case number(Int)
    case op(String)
    case openParen
    case closedParen

    var debugDescription: String {
        switch self {
        case .number(let v):
            return "\(v)"
        case .op(let v):
            return v
        case .openParen:
            return "("
        case .closedParen:
            return ")"
        }
    }
}

class Tokenizer {

    func tokenize(line: String) -> [Token] {
        var tokens: [Token] = []

        var currentNumber = ""

        for character in line {
            if character == " " {
                if !currentNumber.isEmpty {
                    tokens.append(.number(Int(currentNumber)!))
                    currentNumber = ""
                }
            } else if character == "+" {
                tokens.append(.op("+"))
            } else if character == "*" {
                tokens.append(.op("*"))
            } else if character == "(" {
                tokens.append(.openParen)
            } else if character == ")" {
                if !currentNumber.isEmpty {
                    tokens.append(.number(Int(currentNumber)!))
                    currentNumber = ""
                }

                tokens.append(.closedParen)
            } else {
                currentNumber += String(character)
            }
        }

        if !currentNumber.isEmpty {
            tokens.append(.number(Int(currentNumber)!))
        }

        return tokens
    }
}

protocol Node: CustomDebugStringConvertible {
    func evaluate() -> Int
}

struct NumberNode: Node {
    let value: Int

    var debugDescription: String {
        return "\(value)"
    }

    func evaluate() -> Int {
        return value
    }
}

struct OperatorNode: Node {
    let op: String
    let lhs: Node
    let rhs: Node

    var debugDescription: String {
        return "(\(lhs.debugDescription) \(op) \(rhs.debugDescription))"
    }

    func evaluate() -> Int {
        let lValue = lhs.evaluate()
        let rValue = rhs.evaluate()

        switch op {
        case "+":
            return lValue + rValue
        case "*":
            return lValue * rValue
        default:
            fatalError("Unhandled op: \(op)")
        }
    }
}

class Parser {
    let tokens: [Token]
    var head: Int = 0
    let isAdvanced: Bool

    static let precedences: [String:Int] = [
        "+": 2,
        "*": 1
    ]

    init(tokens: [Token], isAdvanced: Bool = false) {
        self.tokens = tokens
        self.isAdvanced = isAdvanced
    }

    func peek() -> Token {
        precondition(head < tokens.count)
        return tokens[head]
    }

    func pop() -> Token {
        precondition(head < tokens.count)

        let value = tokens[head]
        head += 1

        return value
    }

    func nextBinaryIsValid() -> Bool {
        guard head < tokens.count else {
            return false
        }

        guard case .op(_) = peek() else {
            return false
        }

        return true
    }

    func nextPrecedence() -> Int {
        guard head < tokens.count else {
            return -1
        }

        guard case .op(let op) = peek() else {
            return -1
        }

        guard let precedence = Self.precedences[op] else {
            fatalError("Unsupported operator")
        }

        return precedence
    }

    func parse() -> Node {
        return parseExpression()
    }

    func parseExpression() -> Node {
        let node = parsePrimary()
        return parseBinary(node)
    }

    func parseBinary(_ node: Node) -> Node {
        return isAdvanced ? parseBinaryAdvanced(node) : parseBinaryStandard(node)
    }

    func parseBinaryAdvanced(_ node: Node, nodePrecedence: Int = 0) -> Node {
        var lhs = node

        while true {
            let precedence = nextPrecedence()

            if precedence < nodePrecedence {
                return lhs
            }

            guard case let .op(op) = pop() else {
                fatalError("Failed to parse operator")
            }

            var rhs = parsePrimary()
            let nextPrec = nextPrecedence()

            if precedence < nextPrec {
                rhs = parseBinaryAdvanced(rhs, nodePrecedence: precedence + 1)
            }

            lhs = OperatorNode(op: op, lhs: lhs, rhs: rhs)
        }
    }

    func parseBinaryStandard(_ node: Node) -> Node {
        var lhs = node

        while true {
            guard nextBinaryIsValid() else {
                return lhs
            }

            guard case let .op(op) = pop() else {
                fatalError("Failed to parse operator")
            }

            let rhs = parsePrimary()

            lhs = OperatorNode(op: op, lhs: lhs, rhs: rhs)

            if nextBinaryIsValid() {
                lhs = parseBinary(lhs)
            }
        }
    }

    func parseNumber() -> Node {
        guard case let .number(value) = pop() else {
            fatalError("Cannot parse number")
        }

        return NumberNode(value: value)
    }

    func parseParens() -> Node {
        guard case .openParen = pop() else {
            fatalError("Cannot parse open paren")
        }

        let expression = parseExpression()

        guard case .closedParen = pop() else {
            fatalError("Cannot parse close paren")
        }

        return expression
    }

    func parsePrimary() -> Node {
        switch peek() {
        case .number(_):
            return parseNumber()
        case .openParen:
            return parseParens()
        default:
            fatalError("Invalid primary token: \(peek())")
        }
    }
}

let tokenizer = Tokenizer()

print("Part 1:")
print("=======")
print()

var sum = 0

for line in data.split(separator: "\n") {
    let tokens = tokenizer.tokenize(line: String(line))
    print("Tokenized: \(line) -> \(tokens)")

    let parser = Parser(tokens: tokens)
    let node = parser.parse()

    print("Node: \(node)")

    let result = node.evaluate()
    print("Result: \(result)")

    sum += result
}

print("Sum: \(sum)")
print()

print("Part 2:")
print("=======")
print()

sum = 0

for line in data.split(separator: "\n") {
    let tokens = tokenizer.tokenize(line: String(line))
    print("Tokenized: \(line) -> \(tokens)")

    let parser = Parser(tokens: tokens, isAdvanced: true)
    let node = parser.parse()

    print("Node: \(node)")

    let result = node.evaluate()
    print("Result: \(result)")

    sum += result
}

print("Sum: \(sum)")
print()
