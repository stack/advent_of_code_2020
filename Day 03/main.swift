//
//  main.swift
//  Day 03
//
//  Created by Stephen H. Gerstacker on 2020-12-03.
//

import Foundation
import simd

let data = Input

let terrain = data
    .split(separator: "\n")
    .map { Array($0) }

let slopes = [
    SIMD2<Int>(1, 1),
    SIMD2<Int>(3, 1),
    SIMD2<Int>(5, 1),
    SIMD2<Int>(7, 1),
    SIMD2<Int>(1, 2),
]

func run(slope: SIMD2<Int>, terrain: [[Substring.Element]]) -> Int {
    var position = SIMD2<Int>(0, 0)

    var hits = 0

    while position.y < terrain.count {
        let row = terrain[position.y]
        let value = row[position.x % row.count]

        if value == "#" {
            hits += 1
        }

        position &+= slope
    }

    return hits
}

var total = 1

for slope in slopes {
    let result = run(slope: slope, terrain: terrain)
    print("Slope: \(slope), Hits: \(result)")

    total *= result
}

print("Total: \(total)")
