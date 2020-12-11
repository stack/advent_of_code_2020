//
//  main.swift
//  Day 11
//
//  Created by Stephen H. Gerstacker on 2020-12-11.
//

import Foundation

let data = Example

enum Tile: Equatable, CustomDebugStringConvertible {
    case empty
    case taken
    case floor

    var debugDescription: String {
        switch self {
        case .empty:
            return "L"
        case .taken:
            return "#"
        case .floor:
            return "."
        }
    }
}

class Board {

    let initial: [[Tile]]
    var working: [[Tile]]

    init(data: String) {
        var tiles: [[Tile]] = []

        for line in data.split(separator: "\n") {
            var row: [Tile] = []

            for char in line {
                switch char {
                case "L":
                    row.append(.empty)
                case ".":
                    row.append(.floor)
                case "#":
                    row.append(.taken)
                default:
                    fatalError("Unhandled tile: \(char)")
                }
            }

            tiles.append(row)
        }

        initial = tiles
        working = []
    }

    func run() {
        working = initial

        var changed: Int = .max
        var times = 0

        while (changed != 0) {
            changed = step()
            times += 1

            printWorking()
        }

        print("Changes: \(times)")
    }

    private func printWorking() {
        print("--------------")

        for row in working {
            print(row.map { $0.debugDescription }.joined())
        }
    }

    private func step() -> Int {
        var changed = 0
        var next = working

        for (y, row) in working.enumerated() {
            for (x, value) in row.enumerated() {
                if value == .floor {
                    continue
                }

                var count = 0

                let minX = (x == 0) ? 0 : x - 1
                let minY = (y == 0) ? 0 : y - 1
                let maxX = (x == working[y].count - 1) ? working[y].count - 1 : x + 1
                let maxY = (y == working.count - 1) ? working.count - 1 : y + 1

                for testY in (minY ... maxY) {
                    for testX in (minX ... maxX) {
                        if testX == x && testY == y { continue }

                        if working[testY][testX] == .taken {
                            count += 1
                        }
                    }
                }

                switch value {
                case .empty:
                    if count == 0 {
                        next[y][x] = .taken
                        changed += 1
                    }
                case .taken:
                    if count >= 4 {
                        next[y][x] = .empty
                        changed += 1
                    }
                default:
                    break
                }
            }

        }

        working = next

        return changed
    }
}

let board = Board(data: data)
board.run()
