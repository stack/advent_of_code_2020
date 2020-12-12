//
//  main.swift
//  Day 12
//
//  Created by Stephen H. Gerstacker on 2020-12-12.
//

import Foundation

let data = Input

enum Facing {
    case north
    case south
    case east
    case west

    func turnedLeft(_ degrees: Int) -> Facing {
        guard degrees > 0 else { return self }

        let next: Facing

        switch self {
        case .north:
            next = .west
        case .west:
            next = .south
        case .south:
            next = .east
        case .east:
            next = .north
        }

        return next.turnedLeft(degrees - 90)
    }

    func turnedRight(_ degrees: Int) -> Facing {
        guard degrees > 0 else { return self }

        let next: Facing

        switch self {
        case .north:
            next = .east
        case .west:
            next = .north
        case .south:
            next = .west
        case .east:
            next = .south
        }

        return next.turnedRight(degrees - 90)
    }
}

class Boat {

    var facing: Facing = .east
    var latitude: Int = 0
    var longitude: Int = 0

    func run(instructions: [String]) {
        for instruction in instructions {
            step(instruction: instruction)
        }
    }

    private func step(instruction: String) {
        let action = instruction.prefix(1)
        let amountString = instruction.suffix(instruction.count - 1)
        let amount = Int(amountString)!

        switch action {
        case "N":
            latitude += amount
        case "S":
            latitude -= amount
        case "E":
            longitude += amount
        case "W":
            longitude -= amount
        case "L":
            facing = facing.turnedLeft(amount)
        case "R":
            facing = facing.turnedRight(amount)
        case "F":
            switch facing {
            case .north:
                latitude += amount
            case .south:
                latitude -= amount
            case .east:
                longitude += amount
            case .west:
                longitude -= amount
            }
        default:
            fatalError("Unhandled instruction: \(instruction)")
        }
    }
}

class Boat2 {

    var latitude: Int = 0
    var longitude: Int = 0

    var waypointLatitude: Int = 1
    var waypointLongitude: Int = 10

    func run(instructions: [String]) {
        for instruction in instructions {
            step(instruction: instruction)
        }
    }

    private func step(instruction: String) {
        let action = instruction.prefix(1)
        let amountString = instruction.suffix(instruction.count - 1)
        let amount = Int(amountString)!

        switch action {
        case "N":
            waypointLatitude += amount
        case "S":
            waypointLatitude -= amount
        case "E":
            waypointLongitude += amount
        case "W":
            waypointLongitude -= amount
        case "L":
            rotateLeft(amount)
        case "R":
            rotateRight(amount)
        case "F":
            latitude += waypointLatitude * amount
            longitude += waypointLongitude * amount
        default:
            fatalError("Unhandled instruction: \(instruction)")
        }
    }

    private func rotateLeft(_ degrees: Int) {
        guard degrees > 0 else { return }

        let temp = waypointLatitude * -1
        waypointLatitude = waypointLongitude
        waypointLongitude = temp

        rotateLeft(degrees - 90)
    }

    private func rotateRight(_ degrees: Int) {
        guard degrees > 0 else { return }

        let temp = waypointLongitude * -1
        waypointLongitude = waypointLatitude
        waypointLatitude = temp

        rotateRight(degrees - 90)
    }
}

let boat = Boat()
boat.run(instructions: data.split(separator: "\n").map { String($0) })

print("Position: \(boat.latitude), \(boat.longitude)")
print("Distance: \(abs(boat.latitude) + abs(boat.longitude))")

let boat2 = Boat2()
boat2.run(instructions: data.split(separator: "\n").map { String($0) })

print("Position: \(boat2.latitude), \(boat2.longitude)")
print("Distance: \(abs(boat2.latitude) + abs(boat2.longitude))")
