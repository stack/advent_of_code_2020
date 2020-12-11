//
//  main.swift
//  Day 11
//
//  Created by Stephen H. Gerstacker on 2020-12-11.
//

import Foundation

let data = Input

let board = Board(data: data)
board.run(mode: .part2) { (working, _) in
    print("--------------")

    for row in working {
        print(row.map { $0.debugDescription }.joined())
    }
}
