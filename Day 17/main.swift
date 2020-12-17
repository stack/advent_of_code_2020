//
//  main.swift
//  Day 17
//
//  Created by Stephen H. Gerstacker on 2020-12-17.
//

import Foundation

let data = Example

struct Coordinate3D: Hashable {
    let x: Int
    let y: Int
    let z: Int
}

class Dimension {

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
                var line = ""

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

let initial = data.split(separator: "\n").map {
    $0.map { $0 == "." ? 0 : 1 }
}

let dimension = Dimension(start: initial)
dimension.run(steps: 6)

print("Active: \(dimension.active)")
