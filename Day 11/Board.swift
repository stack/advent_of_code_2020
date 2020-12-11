//
//  Board.swift
//  Day 11
//
//  Created by Stephen H. Gerstacker on 2020-12-11.
//

import Foundation

enum Tile: Equatable, CustomDebugStringConvertible {
    case invalid
    case empty
    case occupied
    case floor

    var debugDescription: String {
        switch self {
        case .invalid:
            return "X"
        case .empty:
            return "L"
        case .occupied:
            return "#"
        case .floor:
            return "."
        }
    }
}

enum Mode {
    case part1
    case part2
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
                    row.append(.occupied)
                default:
                    fatalError("Unhandled tile: \(char)")
                }
            }

            tiles.append(row)
        }

        initial = tiles
        working = []
    }

    func run(mode: Mode, stepCallback: ([[Tile]], Int) -> Void) {
        working = initial

        var changed: Int = .max
        var times = 0

        while (changed != 0) {
            switch mode {
            case .part1:
                changed = step()
            case .part2:
                changed = step2()
            }

            if (changed != 0) {
                times += 1
                stepCallback(working, times)
            }
        }

        print("Changes: \(times)")

        let occupied = working.reduce(0) { $0 + $1.reduce(0) { $0 + ($1 == .occupied ? 1 : 0) } }
        print("Occupied: \(occupied)")
    }

    private func tile(x: Int, y: Int) -> Tile {
        if x < 0 { return .invalid }
        if y < 0 { return .invalid }
        if x >= working[0].count { return .invalid }
        if y >= working.count { return .invalid }

        return working[y][x]
    }

    private func step() -> Int {
        var changed = 0
        var next = working

        for (y, row) in working.enumerated() {
            for (x, value) in row.enumerated() {
                if value == .floor { continue }

                var count = 0

                for testY in (y - 1 ... y + 1) {
                    for testX in (x - 1 ... x + 1) {
                        if testX == x && testY == y { continue }

                        let test = tile(x: testX, y: testY)

                        if test == .occupied {
                            count += 1
                        }
                    }
                }

                switch value {
                case .empty:
                    if count == 0 {
                        next[y][x] = .occupied
                        changed += 1
                    }
                case .occupied:
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

    private func step2() -> Int {
        var changed = 0
        var next = working

        for (y, row) in working.enumerated() {
            for (x, value) in row.enumerated() {
                if value == .floor {
                    continue
                }

                var count = 0

                for deltaY in (-1 ... 1) {
                    for deltaX in (-1 ... 1) {
                        if deltaX == 0 && deltaY == 0 { continue }

                        var currentX = x + deltaX
                        var currentY = y + deltaY
                        var keepGoing = true

                        while (keepGoing) {
                            let test = tile(x: currentX, y: currentY)

                            switch test {
                            case .invalid :
                                keepGoing = false
                            case .empty:
                                keepGoing = false
                            case .occupied:
                                count += 1
                                keepGoing = false
                            case .floor:
                                break
                            }

                            currentX += deltaX
                            currentY += deltaY
                        }
                    }
                }

                switch value {
                case .empty:
                    if count == 0 {
                        next[y][x] = .occupied
                        changed += 1
                    }
                case .occupied:
                    if count >= 5 {
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
