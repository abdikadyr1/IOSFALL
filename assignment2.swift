//1
for n in 1...100 {
    if n % 3 == 0 && n % 5 == 0 {
        print("FizzBuzz")
    } else if n % 3 == 0 {
        print("Fizz")
    } else if n % 5 == 0 {
        print("Buzz")
    } else {
        print(n)
    }
}

//2
func isPrime(_ number: Int) -> Bool {
    if number < 2 { return false }
    if number == 2 { return true }
    if number % 2 == 0 { return false }
    var d = 3
    while d * d <= number {
        if number % d == 0 { return false }
        d += 2
    }
    return true
}

//3
import Foundation

func cToF(_ c: Double) -> Double { c * 9/5 + 32 }
func fToC(_ f: Double) -> Double { (f - 32) * 5/9 }
func cToK(_ c: Double) -> Double { c + 273.15 }
func kToC(_ k: Double) -> Double { k - 273.15 }

print("Enter temperature value:", terminator: " ")
guard let vStr = readLine(), let value = Double(vStr) else {
    fatalError("Invalid number.")
}
print("Enter unit (C, F, or K):", terminator: " ")
guard let uStr = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines),
      let unit = uStr.uppercased().first, ["C","F","K"].contains(unit) else {
    fatalError("Invalid unit.")
}

switch unit {
case "C":
    let f = cToF(value)
    let k = cToK(value)
    print(String(format: "%.2f °C = %.2f °F, %.2f K", value, f, k))
case "F":
    let c = fToC(value)
    let k = cToK(c)
    print(String(format: "%.2f °F = %.2f °C, %.2f K", value, c, k))
default: // "K"
    let c = kToC(value)
    let f = cToF(c)
    print(String(format: "%.2f K = %.2f °C, %.2f °F", value, c, f))
}

//4
import Foundation

var list: [String] = []

func showMenu() {
    print("""
    \n=== Shopping List ===
    1) Add item
    2) Remove item
    3) Show list
    4) Exit
    Choose: """, terminator: "")
}

while true {
    showMenu()
    guard let choice = readLine() else { continue }
    switch choice {
    case "1":
        print("Enter item to add:", terminator: " ")
        if let item = readLine(), !item.isEmpty {
            list.append(item)
            print("Added: \(item)")
        }
    case "2":
        print("Enter exact item to remove:", terminator: " ")
        if let item = readLine(), let idx = list.firstIndex(of: item) {
            list.remove(at: idx)
            print("Removed: \(item)")
        } else {
            print("Item not found.")
        }
    case "3":
        print("\nCurrent list (\(list.count)):")
        for (i, it) in list.enumerated() { print("\(i+1). \(it)") }
    case "4":
        print("Goodbye!")
        exit(0)
    default:
        print("Invalid option.")
    }
}

//5
import Foundation

print("Enter a sentence:")
let text = readLine() ?? "Hello, hello world! World?"

let lowered = text.lowercased()
let cleaned = lowered.unicodeScalars.map { CharacterSet.alphanumerics.contains($0) ? Character($0) : ($0 == " ".unicodeScalars.first! ? " " : " ") }.map(String.init).joined()

let words = cleaned.split(separator: " ").map(String.init).filter { !$0.isEmpty }

var freq: [String:Int] = [:]
for w in words { freq[w, default: 0] += 1 }

print("Frequencies:")
for (w,c) in freq.sorted(by: { $0.key < $1.key }) {
    print("\(w): \(c)")
}

//6
func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 { return [] }
    if n == 1 { return [0] }
    var arr = [0, 1]
    while arr.count < n {
        arr.append(arr[arr.count-1] + arr[arr.count-2])
    }
    return arr
}

//7
import Foundation

print("Enter student name and score (e.g., Alice 87). Blank line to finish.")
var records: [(name: String, score: Double)] = []

while true {
    print(">", terminator: " ")
    guard let line = readLine(), !line.trimmingCharacters(in: .whitespaces).isEmpty else { break }
    let parts = line.split(separator: " ")
    guard parts.count >= 2, let score = Double(parts.last!) else {
        print("Format: Name Score")
        continue
    }
    let name = parts.dropLast().joined(separator: " ")
    records.append((name, score))
}

guard !records.isEmpty else { fatalError("No data.") }

let scores = records.map { $0.score }
let avg = scores.reduce(0,+) / Double(scores.count)
let maxVal = scores.max()!
let minVal = scores.min()!
let top = records.first { $0.score == maxVal }!
let low = records.first { $0.score == minVal }!

print(String(format: "\nAverage: %.2f", avg))
print("Highest: \(top.name) (\(top.score))")
print("Lowest:  \(low.name) (\(low.score))")
print("\nStudents:")
for r in records {
    let tag = r.score >= avg ? "↑ above avg" : "↓ below avg"
    print(String(format: "%-20s %.2f  %@", (r.name as NSString).utf8String!, r.score, tag))
}

//8

import Foundation

func isPalindrome(_ text: String) -> Bool {
    let cleaned = text.lowercased().filter { $0.isLetter || $0.isNumber }
    return cleaned == cleaned.reversed()
}

//9
import Foundation

func add(_ a: Double, _ b: Double) -> Double { a + b }
func sub(_ a: Double, _ b: Double) -> Double { a - b }
func mul(_ a: Double, _ b: Double) -> Double { a * b }
func div(_ a: Double, _ b: Double) -> Double {
    if b == 0 { fatalError("Division by zero.") }
    return a / b
}

while true {
    print("\nEnter first number (or 'q' to quit):", terminator: " ")
    guard let aStr = readLine(), aStr.lowercased() != "q" else { break }
    guard let a = Double(aStr) else { print("Invalid."); continue }

    print("Enter operation (+ - * /):", terminator: " ")
    guard let op = readLine(), ["+","-","*","/"].contains(op) else { print("Invalid."); continue }

    print("Enter second number:", terminator: " ")
    guard let bStr = readLine(), let b = Double(bStr) else { print("Invalid."); continue }

    let result: Double
    switch op {
    case "+": result = add(a,b)
    case "-": result = sub(a,b)
    case "*": result = mul(a,b)
    default:
        if b == 0 { print("Error: division by zero."); continue }
        result = div(a,b)
    }
    print("Result = \(result)")
}
print("Calculator closed.")

//10
func hasUniqueCharacters(_ text: String) -> Bool {
    var seen = Set<Character>()
    for ch in text {
        if seen.contains(ch) { return false }
        seen.insert(ch)
    }
    return true
}
