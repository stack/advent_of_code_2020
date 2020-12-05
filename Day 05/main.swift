//
//  main.swift
//  Day 05
//
//  Created by Stephen H. Gerstacker on 2020-12-05.
//

import Foundation

let data = Input

struct BoardingPass: Hashable {
    let row: Int
    let column: Int
    let id: Int

    init(code: Substring) {
        var rowMin = 0
        var rowMax = 127
        let rowCodes = Array(code.prefix(7))

        for rowCode in rowCodes {
            let half = (rowMax - rowMin) / 2

            switch rowCode {
            case "F":
                rowMax = rowMin + half
            case "B":
                rowMin = rowMin + half + 1
            default:
                fatalError("Invalid row code: \(rowCode)")
            }

            // print("\(rowCode) - \(rowMin), \(rowMax)")
        }

        guard rowMin == rowMax else {
            fatalError("Failed to get a row concensus: \(rowMin) vs. \(rowMax)")
        }

        row = rowMin

        var columnMin = 0
        var columnMax = 7
        let columnCodes = Array(code.suffix(3))

        for columnCode in columnCodes {
            let half = (columnMax - columnMin) / 2

            switch columnCode {
            case "L":
                columnMax = columnMin + half
            case "R":
                columnMin = columnMin + half + 1
            default:
                fatalError("Invalid column code: \(columnCode)")
            }

            // print("\(columnCode) - \(columnMin), \(columnMax)")
        }

        guard columnMin == columnMax else {
            fatalError("Failed to get a column concensus: \(columnMin) vs. \(columnMax)")
        }

        column = columnMin

        id = (row * 8) + column
    }

    init(row: Int, column: Int) {
        self.row = row
        self.column = column

        id = (row * 8) + column
    }
}

let passes = data.split(separator: "\n")
    .map { BoardingPass(code: $0) }
    .sorted { $0.id > $1.id }

print("Max Pass: \(passes.first!)")

var existingIDs: Set<BoardingPass> = []

for pass in passes {
    existingIDs.insert(pass)
}

for row in 1 ..< 127 {
    for column in 0 ..< 8 {
        let pass = BoardingPass(row: row, column: column)

        if existingIDs.contains(pass) {
            continue
        }

        let front = BoardingPass(row: row - 1, column: column)
        let back = BoardingPass(row: row + 1, column: column)

        if existingIDs.contains(front) && existingIDs.contains(back) {
            print("Open Pass: \(pass)")
            break
        }
    }
}
