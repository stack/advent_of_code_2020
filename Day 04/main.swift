//
//  main.swift
//  Day 04
//
//  Created by Stephen H. Gerstacker on 2020-12-04.
//

import Foundation

let data1 = Input
let data2 = Input

struct Passport {
    var birthYear: String? = nil
    var issueYear: String? = nil
    var expirationYear: String? = nil
    var height: String? = nil
    var hairColor: String? = nil
    var eyeColor: String? = nil
    var passportID: String? = nil
    var countryID: String? = nil

    mutating func injest(_ line: String) {
        let parts = line.split(separator: " ")
        let pairs = parts.map { part -> (String, String) in
            let data = part.split(separator: ":")
            return (String(data[0]), String(data[1]))
        }

        for pair in pairs {
            switch pair.0 {
            case "byr":
                birthYear = pair.1
            case "iyr":
                issueYear = pair.1
            case "eyr":
                expirationYear = pair.1
            case "hgt":
                height = pair.1
            case "hcl":
                hairColor = pair.1
            case "ecl":
                eyeColor = pair.1
            case "pid":
                passportID = pair.1
            case "cid":
                countryID = pair.1
            default:
                fatalError("Unhandled key: \(pair.0)")
            }
        }
    }

    var birthYearIsPresent: Bool {
        return birthYear != nil
    }

    var birthYearIsValid: Bool {
        guard birthYearIsPresent else { return false }
        guard birthYear!.count == 4 else { return false }
        guard let year = Int(birthYear!) else { return false }

        return year >= 1920 && year <= 2002
    }

    var expirationYearIsPresent: Bool {
        return expirationYear != nil
    }

    var expirationYearIsValid: Bool {
        guard expirationYearIsPresent else { return false }
        guard expirationYear!.count == 4 else { return false }
        guard let year = Int(expirationYear!) else { return false }

        return year >= 2020 && year <= 2030
    }

    var eyeColorIsPresent: Bool {
        return eyeColor != nil
    }

    var eyeColorIsValid: Bool {
        guard eyeColorIsPresent else { return false }

        switch eyeColor! {
        case "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
            return true
        default:
            return false
        }
    }

    var hairColorIsPresent: Bool {
        return hairColor != nil
    }

    var hairColorIsValid: Bool {
        guard hairColorIsPresent else { return false }

        let colorRegex = try! NSRegularExpression(pattern: "^#[0-9a-f]{6}$")
        let colorRange = NSRange(location: 0, length: hairColor!.utf16.count)

        guard colorRegex.firstMatch(in: hairColor!, options: [], range: colorRange) != nil else {
            return false
        }

        return true
    }

    var heightIsPresent: Bool {
        return height != nil
    }

    var heightIsValid: Bool {
        guard heightIsPresent else { return false }

        let heightRegex = try! NSRegularExpression(pattern: "^(\\d+)(cm|in)$")
        let heightRange = NSRange(location: 0, length: height!.utf16.count)

        guard let heightMatch = heightRegex.firstMatch(in: height!, options: [], range: heightRange) else {
            return false
        }

        let heightValueRange = heightMatch.range(at: 1)
        let heightStringRange = Range(heightValueRange, in: height!)!
        let heightValue = Int(height![heightStringRange]) ?? 0

        let heightMetricRange = heightMatch.range(at: 2)
        let heightMetricStringRange = Range(heightMetricRange, in: height!)!
        let heightMetric = height![heightMetricStringRange]

        if heightMetric != "cm" && heightMetric != "in" {
            return false;
        } else if heightMetric == "cm" && (heightValue < 150 || heightValue > 193) {
            return false
        } else if heightMetric == "in" && (heightValue < 59 || heightValue > 76) {
            return false
        }

        return true
    }

    var issueYearIsPresent: Bool {
        return issueYear != nil
    }

    var issueYearIsValid: Bool {
        guard issueYearIsPresent else { return false }
        guard issueYear!.count == 4 else { return false }
        guard let year = Int(issueYear!) else { return false }

        return year >= 2010 && year <= 2020
    }

    var passportIDIsPresent: Bool {
        return passportID != nil
    }

    var passportIDIsValid: Bool {
        guard passportIDIsPresent else { return false }

        let passportRegex = try! NSRegularExpression(pattern: "^[0-9]{9}$")
        let passportRange = NSRange(location: 0, length: passportID!.utf16.count)

        guard passportRegex.firstMatch(in: passportID!, options: [], range: passportRange) != nil else {
            return false
        }

        return true
    }

    var isEmpty: Bool {
        guard !birthYearIsPresent else { return false }
        guard !issueYearIsPresent else { return false }
        guard !expirationYearIsPresent else { return false }
        guard !heightIsPresent else { return false }
        guard !hairColorIsPresent else { return false }
        guard !eyeColorIsPresent else { return false }
        guard !passportIDIsPresent else { return false }

        if countryID != nil {
            return false
        }

        return true
    }

    var isValid: Bool {
        guard birthYearIsPresent else { return false }
        guard issueYearIsPresent else { return false }
        guard expirationYearIsPresent else { return false }
        guard heightIsPresent else { return false }
        guard hairColorIsPresent else { return false }
        guard eyeColorIsPresent else { return false }
        guard passportIDIsPresent else { return false }

        return true
    }

    var isValid2: Bool {
        guard birthYearIsValid else { return false }
        guard issueYearIsValid else { return false }
        guard expirationYearIsValid else { return false }
        guard heightIsValid else { return false }
        guard hairColorIsValid else { return false }
        guard eyeColorIsValid else { return false }
        guard passportIDIsValid else { return false }

        return true
    }
}

// MARK: - Part 1

let lines1 = data1.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false)

var currentPassport = Passport()
var passports: [Passport] = []

for line in lines1 {
    if line == "" {
        passports.append(currentPassport)
        currentPassport = Passport()

        continue
    }

    currentPassport.injest(String(line))
}

if !currentPassport.isEmpty {
    passports.append(currentPassport)
}

let valid1 = passports.reduce(0) { $0 + ($1.isValid ? 1 : 0) }
print("Valid 1: \(valid1) of \(passports.count)")

// MARK: - Testing

var test = Passport(birthYear: "2002")
guard test.birthYearIsValid else { fatalError("BYR not valid") }

test = Passport(birthYear: "2003")
guard !test.birthYearIsValid else { fatalError("BYR is valid") }

test = Passport(issueYear: "2020")
guard test.issueYearIsValid else { fatalError("IYR not valid") }

test = Passport(issueYear: "2021")
guard !test.issueYearIsValid else { fatalError("IYR is valid") }

test = Passport(expirationYear: "2030")
guard test.expirationYearIsValid else { fatalError("EYR not valid") }

test = Passport(expirationYear: "2031")
guard !test.expirationYearIsValid else { fatalError("EYR is valid") }

test = Passport(height: "60in")
guard test.heightIsValid else { fatalError("HGT not valid") }

test = Passport(height: "190cm")
guard test.heightIsValid else { fatalError("HGT not valid") }

test = Passport(height: "190in")
guard !test.heightIsValid else { fatalError("HGT is valid") }

test = Passport(height: "190")
guard !test.heightIsValid else { fatalError("HGT is valid") }

test = Passport(hairColor: "#123abc")
guard test.hairColorIsValid else { fatalError("HCL is not valid") }

test = Passport(hairColor: "#123abz")
guard !test.hairColorIsValid else { fatalError("HCL is valid") }

test = Passport(hairColor: "123abc")
guard !test.hairColorIsValid else { fatalError("HCL is valid") }

test = Passport(eyeColor: "brn")
guard test.eyeColorIsValid else { fatalError("ECL is not valid") }

test = Passport(eyeColor: "wat")
guard !test.eyeColorIsValid else { fatalError("ECL is valid") }

test = Passport(passportID: "000000001")
guard test.passportIDIsValid else { fatalError("PID is not valid") }

test = Passport(passportID: "0123456789")
guard !test.passportIDIsValid else { fatalError("PID is valid") }


// MARK: - Part 2

let lines2 = data2.split(separator: "\n", maxSplits: .max, omittingEmptySubsequences: false)

currentPassport = Passport()
passports.removeAll()

for line in lines2 {
    if line == "" {
        passports.append(currentPassport)
        currentPassport = Passport()

        continue
    }

    currentPassport.injest(String(line))
}

if !currentPassport.isEmpty {
    passports.append(currentPassport)
}

let valid2 = passports.reduce(0) { $0 + ($1.isValid2 ? 1 : 0) }
print("Valid 2: \(valid2) of \(passports.count)")
