//
//  main.swift
//  Day 02
//
//  Created by Stephen H. Gerstacker on 2020-12-02.
//

import Foundation

let data = Input

struct Entry {
    let min: Int
    let max: Int
    let letter: Character
    let password: String

    func isValid() -> Bool {
        var letterCount = 0

        for char in password {
            if char == letter {
                letterCount += 1
            }
        }

        return letterCount >= min && letterCount <= max
    }

    func isValid2() -> Bool {
        let firstOffset = min - 1
        let secondoffset = max - 1

        if firstOffset > password.count || secondoffset > password.count {
            return false
        }

        let firstIndex = password.index(password.startIndex, offsetBy: firstOffset)
        let first = password[firstIndex]

        let secondIndex = password.index(password.startIndex, offsetBy: secondoffset)
        let second = password[secondIndex]

        if (first == letter || second == letter) && first != second {
            return true
        } else {
            return false
        }
    }
}

let entries = data
    .split(separator: "\n")
    .map { line -> Entry in
        let parts = line.split(separator: " ")

        let limits = parts[0].split(separator: "-")
        let min = Int(limits[0])!
        let max = Int(limits[1])!

        let letter = parts[1].first!

        let password = String(parts[2])

        return Entry(min: min, max: max, letter: letter, password: password)
    }

var valid: [Entry] = []
var invalid: [Entry] = []

for entry in entries {
    if entry.isValid() {
        valid.append(entry)
    } else {
        invalid.append(entry)
    }
}

print("Valid 1: \(valid.count)")
print("Invalid 1: \(invalid.count)")

valid.removeAll()
invalid.removeAll()

for entry in entries {
    if entry.isValid2() {
        valid.append(entry)
    } else {
        invalid.append(entry)
    }
}

print("Valid 2: \(valid.count)")
print("Invalid 2: \(invalid.count)")

