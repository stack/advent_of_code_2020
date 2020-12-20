//
//  main.swift
//  Day 20
//
//  Created by Stephen H. Gerstacker on 2020-12-20.
//

import Foundation

let data = Example

struct Tile {
    let id: Int
    let pixels: [[Bool]]

    let topBorder: String
    let bottomBorder: String
    let leftBorder: String
    let rightBorder: String

    init(id: Int, pixels: [[Bool]]) {
        self.id = id
        self.pixels = pixels

        self.topBorder = pixels[0].map { $0 ? "#" : "." }.joined()
        self.bottomBorder = pixels.last!.map { $0 ? "#" : "." }.joined()
        self.leftBorder = pixels.map { $0[0] ? "#" : "." }.joined()
        self.rightBorder = pixels.map { $0.last! ? "#" : "." }.joined()
    }
}

struct Node: Equatable, Hashable {
    let id: Int

    let topBorder: String
    let bottomBorder: String
    let leftBorder: String
    let rightBorder: String

    var rotation = 0
    var verticallyFlipped = false
    var horizontallyFlipped = false

    var topNeighbors: [Node] = []
    var bottomNeighbors: [Node] = []
    var leftNeighbors: [Node] = []
    var rightNeighbors: [Node] = []

    func rotated() -> Node {
        let newRightBorder = topBorder
        let newBottomBorder = String(rightBorder.reversed())
        let newLeftBorder = bottomBorder
        let newTopBorder = String(leftBorder.reversed())

        return Node(id: id, topBorder: newTopBorder, bottomBorder: newBottomBorder, leftBorder: newLeftBorder, rightBorder: newRightBorder, rotation: rotation + 90)
    }

    func flippedVertical() -> Node {
        let newRightBorder = String(rightBorder.reversed())
        let newLeftBorder = String(leftBorder.reversed())
        let newTopBorder = bottomBorder
        let newBottomBorder = topBorder

        return Node(id: id, topBorder: newTopBorder, bottomBorder: newBottomBorder, leftBorder: newLeftBorder, rightBorder: newRightBorder, rotation: rotation, verticallyFlipped: !verticallyFlipped)
    }

    func flippedHorizontal() -> Node {
        let newTopBorder = String(topBorder.reversed())
        let newBottomBorder = String(bottomBorder.reversed())
        let newLeftBorder = rightBorder
        let newRightBorder = leftBorder

        return Node(id: id, topBorder: newTopBorder, bottomBorder: newBottomBorder, leftBorder: newLeftBorder, rightBorder: newRightBorder, horizontallyFlipped: !horizontallyFlipped)
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id &&
            lhs.topBorder == rhs.topBorder &&
            lhs.bottomBorder == rhs.bottomBorder &&
            lhs.leftBorder == rhs.leftBorder &&
            lhs.rightBorder == rhs.rightBorder
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(topBorder)
        hasher.combine(bottomBorder)
        hasher.combine(leftBorder)
        hasher.combine(rightBorder)
    }
}

class Image {
    var tiles: [Tile] = []
    var nodes: Set<Node> = []

    func addTile(id: Int, data: [String]) {
        let pixels = data.map { row -> [Bool] in
            row.map { $0 == "." ? false : true }
        }

        let tile = Tile(id: id, pixels: pixels)
        tiles.append(tile)

        var node = Node(id: tile.id, topBorder: tile.topBorder, bottomBorder: tile.bottomBorder, leftBorder: tile.leftBorder, rightBorder: tile.rightBorder)

        for _ in 0 ... 3 {
            // Append the current state
            nodes.insert(node)

            // Flip vertically
            var flipped = node.flippedVertical()
            nodes.insert(flipped)

            // Flip horizontally
            flipped = node.flippedHorizontal()
            nodes.insert(flipped)

            // Flip both
            flipped = node.flippedHorizontal().flippedVertical()
            nodes.insert(flipped)

            // Rotate it
            node = node.rotated()
        }
    }

    func resolve() {
        // Find all matching neighbors
        var allNodes = Array(nodes)

        for idx in 0 ..< allNodes.count {
            for searchNode in allNodes {
                guard allNodes[idx].id != searchNode.id else { continue }

                if allNodes[idx].topBorder == searchNode.bottomBorder {
                    allNodes[idx].topNeighbors.append(searchNode)
                }

                if allNodes[idx].bottomBorder == searchNode.topBorder {
                    allNodes[idx].bottomNeighbors.append(searchNode)
                }

                if allNodes[idx].leftBorder == searchNode.rightBorder {
                    allNodes[idx].leftNeighbors.append(searchNode)
                }

                if allNodes[idx].rightBorder == searchNode.leftBorder {
                    allNodes[idx].rightNeighbors.append(searchNode)
                }
            }
        }

        // Find the corners
        var topLefts: [Node] = []
        var topRights: [Node] = []
        var bottomLefts: [Node] = []
        var bottomRights: [Node] = []

        for node in allNodes {
            if node.topNeighbors.isEmpty && node.leftNeighbors.isEmpty && !node.bottomNeighbors.isEmpty && !node.rightNeighbors.isEmpty {
                topLefts.append(node)
            }

            if node.topNeighbors.isEmpty && node.rightNeighbors.isEmpty && !node.bottomNeighbors.isEmpty && !node.leftNeighbors.isEmpty {
                topRights.append(node)
            }

            if node.bottomNeighbors.isEmpty && node.leftNeighbors.isEmpty && !node.topNeighbors.isEmpty && !node.rightNeighbors.isEmpty {
                bottomLefts.append(node)
            }

            if node.bottomNeighbors.isEmpty && node.rightNeighbors.isEmpty && !node.topNeighbors.isEmpty && !node.leftNeighbors.isEmpty {
                bottomRights.append(node)
            }
        }

        print("Top Lefts: \(topLefts.map { $0.id })")
        print("Top Rights: \(topRights.map { $0.id })")
        print("Bottom Lefts: \(bottomLefts.map { $0.id })")
        print("Bottom Rights: \(bottomRights.map { $0.id })")
    }
}

let tileRegex = try! NSRegularExpression(pattern: "Tile (\\d+):", options: [])

let image = Image()

var currentID: Int = 0
var currentRows: [String] = []

for line in data.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false) {
    let lineString = String(line)

    let range = NSRange(lineString.startIndex ..< lineString.endIndex, in: lineString)

    if let match = tileRegex.firstMatch(in: lineString, options: [], range: range) {
        let idRange = Range(match.range(at: 1), in: lineString)!
        let id = Int(lineString[idRange])!

        currentID = id
    } else if lineString.isEmpty {
        image.addTile(id: currentID, data: currentRows)
        currentID = 0
        currentRows.removeAll()
    } else {
        currentRows.append(lineString)
    }
}

if currentID != 0 {
    image.addTile(id: currentID, data: currentRows)
}

image.resolve()
