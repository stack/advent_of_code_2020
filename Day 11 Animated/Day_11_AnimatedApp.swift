//
//  Day_11_AnimatedApp.swift
//  Day 11 Animated
//
//  Created by Stephen H. Gerstacker on 2020-12-11.
//

import SwiftUI
import Utilities

let tileSize = 20

@main
struct Day_11_AnimatedApp: App {

    let data: String
    let width: Int
    let height: Int
    let board: Board

    init() {
        data = Input

        let lines = data.split(separator: "\n")
        width = lines[0].count
        height = lines.count

        board = Board(data: data)
    }

    var body: some Scene {
        WindowGroup {
            RenderableWorkView(width: width * tileSize, height: height * tileSize, frameTime: 0.05) { animator in
                board.run(mode: .part2) { (working, step) in
                    guard step % 2 == 0 else { return }

                    animator.draw { (context) in
                        for (y, row) in working.enumerated() {
                            for (x, value) in row.enumerated() {
                                let rect = CGRect(x: x * tileSize, y: y * tileSize, width: tileSize, height: tileSize)

                                let red: CGFloat
                                let green: CGFloat
                                let blue: CGFloat
                                let alpha: CGFloat = 1.0

                                switch value {
                                case .invalid:
                                    red = 191.0 / 255.0
                                    green = 60.0 / 255.0
                                    blue = 48.0 / 255.0
                                case .floor:
                                    red = 242.0 / 255.0
                                    green = 239.0 / 255.0
                                    blue = 233.0 / 255.0
                                case .empty:
                                    red = 54.0 / 255.0
                                    green = 200.0 / 255.0
                                    blue = 217.0 / 255.0
                                case .occupied:
                                    red = 3.0 / 255.0
                                    green = 90.0 / 255.0
                                    blue = 166.0 / 255.0
                                }

                                let color = CGColor(red: red, green: green, blue: blue, alpha: alpha)

                                context.setFillColor(color)
                                context.fill(rect)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
