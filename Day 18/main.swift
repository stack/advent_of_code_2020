//
//  main.swift
//  Day 18
//
//  Created by Stephen H. Gerstacker on 2020-12-18.
//

import Foundation

let data = Examples

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

    init(tokens: [Token]) {
        self.tokens = tokens
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

    func parse() -> Node {
        return parseExpression()
    }

    func parseExpression() -> Node {
        let node = parsePrimary()
        return parseBinary(node)
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

    func parseBinary(_ node: Node) -> Node {
        var lhs = node

        while true {
            guard nextBinaryIsValid() else {
                return lhs
            }

            guard case let .op(op) = pop() else {
                fatalError("Failed to parse operator")
            }

            var rhs = parsePrimary()

            if nextBinaryIsValid() {
                rhs = parseBinary(rhs)
            }

            lhs = OperatorNode(op: op, lhs: lhs, rhs: rhs)
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

for line in data.split(separator: "\n") {
    let tokens = tokenizer.tokenize(line: String(line))
    print("Tokenized: \(line) -> \(tokens)")

    let parser = Parser(tokens: tokens)
    let node = parser.parse()

    print("Node: \(node)")
    print("Result: \(node.evaluate())")
}
