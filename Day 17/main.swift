//
//  main.swift
//  Day 17
//
//  Created by Stephen H. Gerstacker on 2020-12-17.
//

import Foundation

let data = Input

struct Coordinate3D: Hashable, CustomDebugStringConvertible {
    let x: Int
    let y: Int
    let z: Int

    var debugDescription: String {
        return "<\(x), \(y), \(z)>"
    }
}

struct Coordinate4D: Hashable, CustomDebugStringConvertible {
    let x: Int
    let y: Int
    let z: Int
    let w: Int

    var debugDescription: String {
        return "<\(x), \(y), \(z), \(w)>"
    }
}

class Dimension3D {

    var cubes: [Coordinate3D:Int] = [:]
    var width: Int
    var height: Int
    var depth: Int

    var active: Int {
        return cubes.values.reduce(0, +)
    }

    init(start: [[Int]]) {
        height = start.count
        width = start[0].count
        depth = 1

        for (y, row) in start.enumerated() {
            for (x, value) in row.enumerated() {
                let realX = x - (row.count / 2)
                let realY = y - (start.count / 2)
                let realZ = 0

                let coordinate = Coordinate3D(x: realX, y: realY, z: realZ)
                cubes[coordinate] = value
            }
        }
    }

    private func value(x: Int, y: Int, z: Int) -> Int {
        let coordinate = Coordinate3D(x: x, y: y, z: z)
        return value(cooridnate: coordinate)
    }

    private func value(cooridnate: Coordinate3D) -> Int {
        return cubes[cooridnate] ?? 0
    }

    func run(steps: Int) {
        print("Before any cycles:")
        print()
        printState()

        for s in 0 ..< steps {
            step()

            print("After cycle \(s+1)")
            print()
            printState()
        }
    }

    private func expand() {
        var expandWidth = false
        var expandHeight = false
        var expandDepth = false

        // Expand the width?
        for z in (depth / -2) ... (depth / 2) {
            for y in (height / -2) ... (height / 2) {
                for x in [width / -2, width / 2] {
                    if value(x: x, y: y, z: z) == 1 {
                        expandWidth = true
                        break
                    }
                }
            }
        }

        // Expand the height?
        for z in (depth / -2) ... (depth / 2) {
            for x in (width / -2) ... (width / 2) {
                for y in [ height / -2, height / 2] {
                    if value(x: x, y: y, z: z) == 1 {
                        expandHeight = true
                        break
                    }
                }
            }
        }

        // Expand the depth?
        for x in (width / -2) ... (width / 2) {
            for y in (height / -2) ... (height / 2) {
                for z in [depth / -2, depth / 2] {
                    if value(x: x, y: y, z: z) == 1 {
                        expandDepth = true
                        break
                    }
                }
            }
        }

        if expandWidth { width += 2 }
        if expandHeight { height += 2 }
        if expandDepth { depth += 2 }
    }

    private func totalNeighbors(x: Int, y: Int, z: Int) -> Int {
        let coordinate = Coordinate3D(x: x, y: y, z: z)
        return totalNeighbors(coordinate: coordinate)
    }

    private func totalNeighbors(coordinate: Coordinate3D) -> Int {
        var result = 0

        for deltaZ in -1 ... 1 {
            for deltaY in -1 ... 1 {
                for deltaX in -1 ... 1 {
                    let neighborCoordinate = Coordinate3D(x: coordinate.x + deltaX, y: coordinate.y + deltaY, z: coordinate.z + deltaZ)

                    guard neighborCoordinate != coordinate else { continue }

                    result += value(cooridnate: neighborCoordinate)
                }
            }
        }

        return result
    }

    private func step() {
        // Expand if necessary
        expand()

        // Check each coordinate
        var next: [Coordinate3D:Int] = [:]

        for z in (depth / -2) ... (depth / 2) {
            for y in (height / -2) ... (height / 2) {
                for x in (width / -2) ... (width / 2) {
                    let current = Coordinate3D(x: x, y: y, z: z)

                    let currentValue = value(cooridnate: current)
                    let neighbors = totalNeighbors(coordinate: current)

                    if currentValue == 1 {
                        if neighbors == 2 || neighbors == 3 {
                            next[current] = 1
                        } else {
                            next[current] = 0
                        }
                    } else {
                        if neighbors == 3 {
                            next[current] = 1
                        } else {
                            next[current] = 0
                        }
                    }
                }
            }
        }

        cubes = next
    }

    private func printState() {
        for z in (depth / -2) ... (depth / 2) {
            print("z=\(z)")

            for y in (height / -2) ... (height / 2) {
                var line = String(y).padding(toLength: 4, withPad: " ", startingAt: 0)

                for x in (width / -2) ... (width / 2) {
                    let output = value(x: x, y: y, z: z)
                    line += output == 0 ? "." : "#"
                }

                print(line)
            }

            print()
        }
    }
}

class Dimension4D {

    var cubes: [Coordinate4D:Int] = [:]
    var width: Int
    var height: Int
    var depth: Int
    var dimensions: Int

    var active: Int {
        return cubes.values.reduce(0, +)
    }

    init(start: [[Int]]) {
        height = start.count
        width = start[0].count
        depth = 1
        dimensions = 1

        for (y, row) in start.enumerated() {
            for (x, value) in row.enumerated() {
                let realX = x - (row.count / 2)
                let realY = y - (start.count / 2)
                let realZ = 0
                let realW = 0

                let coordinate = Coordinate4D(x: realX, y: realY, z: realZ, w: realW)
                cubes[coordinate] = value
            }
        }
    }

    private func value(x: Int, y: Int, z: Int, w: Int) -> Int {
        let coordinate = Coordinate4D(x: x, y: y, z: z, w: w)
        return value(cooridnate: coordinate)
    }

    private func value(cooridnate: Coordinate4D) -> Int {
        return cubes[cooridnate] ?? 0
    }

    func run(steps: Int) {
        print("Before any cycles:")
        print()
        printState()

        for s in 0 ..< steps {
            step()

            print("After cycle \(s+1)")
            print()
            printState()
        }
    }

    private func expand() {
        var expandWidth = false
        var expandHeight = false
        var expandDepth = false
        var expandDimensions = false

        // Expand the width?
        for w in (dimensions / -2) ... (dimensions / 2) {
            for z in (depth / -2) ... (depth / 2) {
                for y in (height / -2) ... (height / 2) {
                    for x in [width / -2, width / 2] {
                        if value(x: x, y: y, z: z, w: w) == 1 {
                            expandWidth = true
                            break
                        }
                    }
                }
            }
        }

        // Expand the height?
        for w in (dimensions / -2) ... (dimensions / 2) {
            for z in (depth / -2) ... (depth / 2) {
                for x in (width / -2) ... (width / 2) {
                    for y in [ height / -2, height / 2] {
                        if value(x: x, y: y, z: z, w: w) == 1 {
                            expandHeight = true
                            break
                        }
                    }
                }
            }
        }

        // Expand the depth?
        for w in (dimensions / -2) ... (dimensions / 2) {
            for x in (width / -2) ... (width / 2) {
                for y in (height / -2) ... (height / 2) {
                    for z in [depth / -2, depth / 2] {
                        if value(x: x, y: y, z: z, w: w) == 1 {
                            expandDepth = true
                            break
                        }
                    }
                }
            }
        }

        // Expand the dimensions?
        for z in (depth / -2) ... (depth / 2) {
            for y in (height / -2) ... (height / 2) {
                for x in (width / -2) ... (width / 2) {
                    for w in [dimensions / -2, dimensions / 2] {
                        if value(x: x, y: y, z: z, w: w) == 1 {
                            expandDimensions = true
                            break
                        }
                    }
                }
            }
        }

        if expandWidth { width += 2 }
        if expandHeight { height += 2 }
        if expandDepth { depth += 2 }
        if expandDimensions { dimensions += 2 }
    }

    private func totalNeighbors(x: Int, y: Int, z: Int, w: Int) -> Int {
        let coordinate = Coordinate4D(x: x, y: y, z: z, w: w)
        return totalNeighbors(coordinate: coordinate)
    }

    private func totalNeighbors(coordinate: Coordinate4D) -> Int {
        var result = 0

        for deltaW in -1 ... 1 {
            for deltaZ in -1 ... 1 {
                for deltaY in -1 ... 1 {
                    for deltaX in -1 ... 1 {
                        let neighborCoordinate = Coordinate4D(x: coordinate.x + deltaX, y: coordinate.y + deltaY, z: coordinate.z + deltaZ, w: coordinate.w + deltaW)

                        guard neighborCoordinate != coordinate else { continue }

                        result += value(cooridnate: neighborCoordinate)
                    }
                }
            }
        }

        return result
    }

    private func step() {
        // Expand if necessary
        expand()

        // Check each coordinate
        var next: [Coordinate4D:Int] = [:]

        for w in (dimensions / -2) ... (dimensions / 2) {
            for z in (depth / -2) ... (depth / 2) {
                for y in (height / -2) ... (height / 2) {
                    for x in (width / -2) ... (width / 2) {
                        let current = Coordinate4D(x: x, y: y, z: z, w: w)

                        let currentValue = value(cooridnate: current)
                        let neighbors = totalNeighbors(coordinate: current)

                        if currentValue == 1 {
                            if neighbors == 2 || neighbors == 3 {
                                next[current] = 1
                            } else {
                                next[current] = 0
                            }
                        } else {
                            if neighbors == 3 {
                                next[current] = 1
                            } else {
                                next[current] = 0
                            }
                        }
                    }
                }
            }
        }

        cubes = next
    }

    private func printState() {
        for w in (dimensions / -2) ... (dimensions / 2) {
            for z in (depth / -2) ... (depth / 2) {
                print("z=\(z), w=\(w)")

                for y in (height / -2) ... (height / 2) {
                    var line = String(y).padding(toLength: 4, withPad: " ", startingAt: 0)

                    for x in (width / -2) ... (width / 2) {
                        let output = value(x: x, y: y, z: z, w: w)
                        line += output == 0 ? "." : "#"
                    }

                    print(line)
                }

                print()
            }
        }
    }
}

let initial = data.split(separator: "\n").map {
    $0.map { $0 == "." ? 0 : 1 }
}

let dimension3D = Dimension3D(start: initial)
dimension3D.run(steps: 6)

print("Active: \(dimension3D.active)")

let dimension4D = Dimension4D(start: initial)
dimension4D.run(steps: 6)

print("Active: \(dimension4D.active)")
