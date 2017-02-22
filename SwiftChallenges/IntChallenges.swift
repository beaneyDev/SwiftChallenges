//
//  IntChallenges.swift
//  SwiftChallenges
//
//  Created by Matt Beaney on 23/12/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation

class IntChallenge16 {
    //My solution
    func divide() {
        for i in 0...100 {
            var stringy = ""
            if i % 3 == 0 {
                stringy += "Fizz "
            }
            
            if i % 5 == 0 {
                stringy += "Buzz "
            }
            
            if stringy != "" {
                print("\(i) - \(stringy)")
            } else {
                print("\(i)")
            }
        }
    }
    
    //ifelse.
    func challenge16a() {
        for i in 1...100 {
            if i % 3 == 0 && i % 5 == 0 {
                print("Fizz Buzz")
            } else if i % 3 == 0 {
                print("Fizz")
            } else if i % 5 == 0 {
                print("Buzz")
            } else {
                print(i)
            }
        }
    }
    
    //nested if for efficiency.
    func challenge16b() {
        for i in 1...100 {
            if i % 3 == 0 {
                if i % 5 == 0 {
                    print("Fizz Buzz")
                } else {
                    print("Fizz")
                }
            } else if i % 5 == 0 {
                print("Buzz")
            } else {
                print(i)
            }
        }
    }
    
    //Cool forEach...this is awesome
    func challenge16c() {
        (1...100).forEach { print($0 % 3 == 0 ? $0 % 5 == 0 ? "Fizz Buzz" : "Fizz" : $0 % 5 == 0 ? "Buzz" : "\($0)") }
    }
    
    func tests() {
        divide()
    }
}

class IntChallenge17 {
    //arc4random_uniform best random generator.
    func randomNumberForRange(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    
    func tests() {
        assert(Array(1...5).contains(randomNumberForRange(min: 1, max: 5)))
        assert(Array(8...10).contains(randomNumberForRange(min: 8, max: 10)))
        assert(randomNumberForRange(min: 12, max: 12) == 12)
        assert(Array(12...18).contains(randomNumberForRange(min: 12, max: 18)))
    }
}

class IntChallenge18 {
    //My Solution
    func powTo(int: Int, toPower: Int) -> Int {
        var baseInt = int
        for _ in 1..<toPower {
            baseInt *= int
        }
        
        return baseInt
    }
    
    //TODO: Another recursion function
    //Solution using recursion
    func challenge18b(number: Int, power: Int) -> Int {
        guard number > 0, power > 0 else { return 0 }
        if power == 1 { return number }
        
        return number * challenge18b(number: number, power: power - 1)
    }
    
    
    func tests() {
        assert(powTo(int: 4, toPower: 3) == 64)
        assert(powTo(int: 2, toPower: 8) == 256)
        
        assert(challenge18b(number: 4, power: 3) == 64)
        assert(challenge18b(number: 2, power: 8) == 256)
    }
}

class IntChallenge19 {
    func swapNumbersByTuple(a: Int, b: Int) -> (Int, Int) {
        var a = a
        var b = b
        
        (a, b) = (b, a)
        return (a, b)
    }
    
    func swapNumbersUsingNumberacy(a: Int, b: Int) -> (Int, Int) {
        var a = a
        var b = b
        
        a = a + b
        b = a - b
        a = a - b
        
        return (a, b)
    }
    
    //I don't really understand this solution, it's called a bitwise operator or XOR gate.
    func swapNumbersUsingXOR(a: Int, b: Int) -> (Int, Int) {
        var a = a
        var b = b
        
        a = a ^ b
        b = a ^ b
        a = a ^ b
        
        return (a, b)
    }
    
    func swapNumbersUsingSwap(a: Int, b: Int) -> (Int, Int) {
        var a = a
        var b = b
        
        swap(&a, &b)
        return (a, b)
    }
    
    
    func tests() {
        let ab = swapNumbersByTuple(a: 5, b: 6)
        let ab2 = swapNumbersUsingNumberacy(a: 5, b: 6)
        let ab3 = swapNumbersUsingXOR(a: 5, b: 6)
        let ab4 = swapNumbersUsingSwap(a: 5, b: 6)

        assert(ab.0 == 6 && ab.1 == 5)
        assert(ab2.0 == 6 && ab2.1 == 5)
        assert(ab3.0 == 6 && ab3.1 == 5)
        assert(ab4.0 == 6 && ab4.1 == 5)
    }
}

class IntChallenge20 {
    //My solution
    func isPrime(number: Int) -> Bool {
        for i in 2..<number {
            if number % i == 0 {
                return false
            }
        }
        
        return true
    }
    
    //More efficient version - take a square root of the number, and only modulo check up to that point.
    func challenge20b(number: Int) -> Bool {
        guard number >= 2 else { return false }
        guard number != 2 else { return true }
        let max = Int(ceil(sqrt(Double(number))))
        
        for i in 2 ... max {
            if number % i == 0 {
                return false
            }
        }
        
        return true
    }
    
    func tests() {
        assert(isPrime(number: 11))
        assert(isPrime(number: 13))
        assert(!isPrime(number: 4))
        assert(!isPrime(number: 9))
        assert(isPrime(number: 16777259))
        
        assert(challenge20b(number: 11))
        assert(challenge20b(number: 13))
        assert(!challenge20b(number: 4))
        assert(!challenge20b(number: 9))
        assert(challenge20b(number: 16777259))
    }
}

class IntChallenge21 {
    //My solution
    func nextNumberWithSame1s(number: Int) -> (Int, Int) {
        let oneCount = Array(String(number, radix: 2).characters).filter({
            $0 == "1"
        }).count
        
        var i = number + 1
        var foundNextHighest = false
        
        while !foundNextHighest {
            let oneCount2 = Array(String(i, radix: 2).characters).filter({
                $0 == "1"
            }).count
            
            if oneCount2 == oneCount {
                foundNextHighest = true
                break
            }
            
            i += 1
        }
        
        var j = number - 1
        var foundNextLowest = false
        
        while !foundNextLowest && j > 0 {
            let oneCount3 = Array(String(j, radix: 2).characters).filter({
                $0 == "1"
            }).count
            
            if oneCount3 == oneCount {
                foundNextLowest = true
                break
            }
            
            j -= 1
        }
        
        return (i, j)
    }
    
    //Avoiding code duplication.
    func challenge21b(number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
        func ones(in number: Int) -> Int {
            let currentBinary = String(number, radix: 2)
            return currentBinary.characters.filter { $0 == "1" }.count
        }
        
        let targetOnes = ones(in: number)
        var nextHighest: Int? = nil
        var nextLowest: Int? = nil
        
        for i in number + 1...Int.max {
            if ones(in: i) == targetOnes {
                nextHighest = i
                break
            }
        }
        
        for i in (0 ..< number).reversed() {
            if ones(in: i) == targetOnes {
                nextLowest = i
                break
            }
        }
        
        return (nextHighest, nextLowest)
    }
    
    func tests() {
        assert(nextNumberWithSame1s(number: 12) == (17, 10))
        assert(nextNumberWithSame1s(number: 28) == (35, 26))
    }
}

class IntChallenge22 {
    //My solution
    func reverseBinary(number: UInt) -> UInt {
        let numString = String(number)
        if numString.characters.count < 8 {
            let leadingZeros = Array(0..<8 - numString.characters.count).map({_ in 
                return "0"
            }).joined() + numString
            return UInt(String(leadingZeros.characters.reversed()), radix: 2)!
        }
        
        return UInt(String(numString.characters.reversed()), radix: 2)!
    }
    
    //Their solution using "repeating" String initialiser.
    func challenge22(number: UInt) -> UInt {
        let binary = String(number, radix: 2)
        let paddingAmount = 8 - binary.characters.count
        let paddedBinary = String(repeating: "0", count: paddingAmount) + binary
        let reversedBinary = String(paddedBinary.characters.reversed())
        return UInt(reversedBinary, radix: 2)!
    }
    
    func tests() {
        assert(reverseBinary(number: 100000) == 4)
        assert(reverseBinary(number: 101001) == 148)
        
        assert(reverseBinary(number: 00000100) == 32)
        assert(reverseBinary(number: 10010100) == 41)
        
        //Their solution
        assert(challenge22(number: 100000) == 4)
        assert(challenge22(number: 101001) == 148)
        
        assert(challenge22(number: 00000100) == 32)
        assert(challenge22(number: 10010100) == 41)
    }
}

class IntChallenge23 {
    //My Solution
    func numbersOnly(string: String) -> Bool {
        let count = string.characters.filter({
            Int(String($0)) != nil
        })
        
        return count.count == string.characters.count
    }
    
    //Using unsigned int, but still has limits.
    func challenge23(string: String) -> Bool {
        return UInt(string) != nil
    }
    
    //For loop brute search - similar to my solution.
    func challenge23a(string: String) -> Bool {
        for letter in string.characters {
            if Int(String(letter)) == nil {
                return false
            }
        }
        
        return true
    }
    
    //Handles non-English numbers
    //inverted means it will look for any character NOT in the specified set.
    func challenge23b(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    //Same as above, but conforms to just 0-9
    func challenge23c(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789").inverted) == nil
    }
    
    
    func tests() {
        assert(numbersOnly(string: "01010101"))
        assert(numbersOnly(string: "123456789"))
        assert(numbersOnly(string: "9223372036854775808"))
        assert(!numbersOnly(string: "1.01"))
        
        assert(challenge23(string: "01010101"))
        assert(challenge23(string: "123456789"))
        assert(challenge23(string: "9223372036854775808"))
        assert(!challenge23(string: "1.01"))
        
        assert(challenge23a(string: "01010101"))
        assert(challenge23a(string: "123456789"))
        assert(challenge23a(string: "9223372036854775808"))
        assert(!challenge23a(string: "1.01"))
        
        assert(challenge23b(string: "01010101"))
        assert(challenge23b(string: "123456789"))
        assert(challenge23b(string: "9223372036854775808"))
        assert(!challenge23b(string: "1.01"))
        
        assert(challenge23c(string: "01010101"))
        assert(challenge23c(string: "123456789"))
        assert(challenge23c(string: "9223372036854775808"))
        assert(!challenge23c(string: "1.01"))
    }
}

class IntChallenge24 {
    //My regex solution
    func addNumbersInStringRegex(string: String) -> Int {
        var total = 0
        
        for match in RegexUtil.matches(for: "[0-9]+", in: string) {
            total += Int(match)!
        }
        
        return total
    }
    
    //My brute approach
    func addNumbersInString(string: String) -> Int {
        var total = 0
        var currentNum = ""
        
        for character in string.characters {
            if Int(String(character)) != nil {
                currentNum += String(character)
            } else {
//                My solution, but theirs is neater.
//                if let currentNumAsNum = Int(currentNum) {
//                    total += currentNumAsNum
//                    currentNum = ""
//                }
                
                total += Int(currentNum) ?? 0
                currentNum = ""
            }
        }
        
        if let currentNumAsNum = Int(currentNum) {
            total += currentNumAsNum
            currentNum = ""
        }
        
        return total
    }
    
    //Their Regex
    func challenge24b(string: String) -> Int {
        let regex = try! NSRegularExpression(pattern: "(\\d+)", options: [])
        let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        let allNumbers = matches.flatMap { Int((string as NSString).substring(with: $0.range)) }
        
        return allNumbers.reduce(0, +)
    }
    
    func tests() {
        assert(addNumbersInStringRegex(string: "a1b2c3") == 6)
        assert(addNumbersInStringRegex(string: "a10b20c30") == 60)
        assert(addNumbersInStringRegex(string: "h8ers") == 8)
        
        assert(addNumbersInString(string: "a1b2c3") == 6)
        assert(addNumbersInString(string: "a10b20c30") == 60)
        assert(addNumbersInString(string: "h8ers") == 8)
    }
}

class IntChallenge25 {
    //My genuinely socking solution - DOESN'T SATISFY 15 and 3
    func squareRoot(number: Int) -> Int {
        for i in 0..<number {
            if i * i == number {
                return i
            }
        }
        
        return 0
    }
    
    //Their supposedly bad solution (still better than mine!)
    func challenge25a(number: Int) -> Int {
        for i in 0 ... number / 2 {
            if i * i > number {
                return i - 1
            }
        }
        
        return 0
    }
    
    //MARK: Uses binary search.
    func challenge25b(number: Int) -> Int {
        guard number != 1 else { return 1 }
        
        var lowerBound = 0
        var upperBound = 1 + number / 2
        
        while lowerBound + 1 < upperBound {
            let middle = (lowerBound + upperBound) / 2 //((upperBound - lowerBound) / 2)
            let middleSquared = middle * middle
            
            if middleSquared == number {
                return middle
            } else if middleSquared < number {
                lowerBound = middle
            } else {
                upperBound = middle
            }
        }
        
        return lowerBound
    }
    
    func challenge25c(input: Int) -> Int {
        return Int(floor(pow(Double(input), 0.5)))
    }
    
    func tests() {
        assert(squareRoot(number: 9) == 3)
        assert(squareRoot(number: 16777216) == 4096)
        assert(squareRoot(number: 16) == 4)
        //assert(squareRoot(number: 15) == 3)
        
        assert(challenge25a(number: 9) == 3)
        assert(challenge25a(number: 16777216) == 4096)
        assert(challenge25a(number: 16) == 4)
        assert(challenge25a(number: 15) == 3)
        
        assert(challenge25b(number: 100) == 10)
    }
}

class IntChallenge26 {
    //Still technically using - operator.
    func subtract(subtract: Int, from: Int) -> Int {
        return subtract + -from
    }
    
    //Still uses -1 but not as a unary operator.
    func subtractUsingTimes(subtract: Int, from: Int) -> Int {
        return subtract + (-1 * from)
    }
    
    //This flips all the binary numbers.
    //The furthest left bit indicates whether or not the number is positive or negative.
    //Flipping all of the bits will result in it being a negative version of the previous number, but -1.
    //e.g. 
    //00000001 is 1
    //11111110 is -2
    //~1 + 1 == -1
    //You now have a negative number without using -.
    func challenge26(subtract: Int, from: Int) -> Int {
        return from + (~subtract + 1)
    }
    
    func tests() {
        assert(subtract(subtract: 5, from: 9) == 4)
        assert(subtract(subtract: 10, from: 30) == 4)
        
        assert(subtractUsingTimes(subtract: 5, from: 9) == 4)
        assert(subtractUsingTimes(subtract: 10, from: 30) == 4)
    }
}
