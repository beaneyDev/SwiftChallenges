//
//  StringChallenges.swift
//  SwiftChallenges
//
//  Created by Matt Beaney on 23/12/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation

class StringChallenge1 {
    func challenge1(input: String) -> Bool {
        return Set(input.characters).count == input.characters.count
    }
    
    func test() {
        assert(challenge1(input: "No duplicates") == true, "Challenge 1 failed")
        assert(challenge1(input: "abcdefghijklmnopqrstuvwxyz") == true, "Challenge 1 failed")
        assert(challenge1(input: "AaBbCc") == true, "Challenge 1 failed")
        assert(challenge1(input: "Hello, world") == false, "Challenge 1 failed")
    }
}

class StringChallenge2 {
    func challenge2(input: String) -> Bool {
        return String(input.characters.reversed()).lowercased() == String(input.characters).lowercased()
    }
    
    func test() {
        assert(challenge2(input: "helloworld") == false, "Challenge 2 failed")
        assert(challenge2(input: "rotator") == true, "Challenge 2 failed")
        assert(challenge2(input: "Never odd or even") == false, "Challenge 2 failed")
        assert(challenge2(input: "Rats live on no evil star") == true, "Challenge 2 failed")
    }
}

class StringChallenge3 {
    func challenge3(input1: String, input2: String) -> Bool {
        return input1.characters.sorted() == input2.characters.sorted()
    }
    
    func test() {
        assert(challenge3(input1: "abca", input2: "abca") == true)
        assert(challenge3(input1: "abc", input2: "cba") == true)
        assert(challenge3(input1: " a1 b2 ", input2: "b 1 a 2") == true)
        assert(challenge3(input1: "abc", input2: "abca") == false)
        assert(challenge3(input1: "abc", input2: "Abc") == false)
        assert(challenge3(input1: "abc", input2: "cbAa") == false)
    }
}

class StringChallenge4 {
    func test() {
        assert("Hello world!".fuzzySearch(term: "hello", caseSensitive: false) == true)
        assert("HELLO WORLD".fuzzySearch(term: "hello", caseSensitive: true) == false)
        assert("HeLo".fuzzySearch(term: "HeLo", caseSensitive: true) == true)
    }
}

extension String {
    func fuzzySearch(term: String, caseSensitive: Bool) -> Bool {
        if caseSensitive {
            return self.range(of: term) != nil
        }
        
        return self.uppercased().range(of: term.uppercased()) != nil
    }
}

class StringChallenge5 {
    //MOST EFFICIENT SOLUTION
    func countCharInString(string: String, charToCompare: Character) -> Int {
        var index = 0
        for char in string.characters {
            if char == charToCompare {
                index += 1
            }
        }
        
        return index
    }
    
    //MOST READABLE SOLUTION, used reduce.
    func countCharInStringWithReducer(string: String, charToCompare: Character) -> Int {
        return string.characters.reduce(0) {
            //$1 is the actual character which gets passed in by default, $0 is the count that was passed into the function.
            $1 == charToCompare ? $0 + 1 : $0
        }
    }
    
    //SLOWEST SOLUTION, DON'T USE THIS.
    func countCharInStringWithCountedSet(string: String, charToCompare: Character) -> Int {
        let array = string.characters.map({
            String($0)
        })
        
        let counted = NSCountedSet(array: array)
        return counted.count(for: charToCompare)
    }
    
    //THINKING OUTSIDE THE BOX.
    func countCharInStringUsingReplace(string: String, charToCompare: String) -> Int {
        let replaced = string.replacingOccurrences(of: charToCompare, with: "")
        return string.characters.count - replaced.characters.count
    }
    
    func test() {
        assert(countCharInString(string: "Abcdd", charToCompare: "d") == 2)
        assert(countCharInStringWithReducer(string: "Abcdd", charToCompare: "d") == 2)
        assert(countCharInStringWithCountedSet(string: "Abcdd", charToCompare: "d") == 0)
        assert(countCharInStringUsingReplace(string: "Abcdd", charToCompare: "d") == 2)
    }
}

//Remove duplicates from a string
class StringChallenge6 {
    
    //Using sets - less efficient.
    func removeDuplicatesUsingSet(string: String) -> String {
        //Map to array of strings
        let arrayOfStrings = string.characters.map { String($0) }
        
        //Pass array into ordered set to filter the duplicates
        let ordered = NSOrderedSet(array: arrayOfStrings)
        
        //Convert ordered set back to an array of strings
        let array = Array(ordered) as! Array<String>
        return array.joined()
    }
    
    //Brute force approach.
    func removeDuplicates(string: String) -> String {
        var newChars = [Character]()
        for char in string.characters {
            if newChars.contains(char) {
                continue
            } else {
                newChars.append(char)
            }
        }
        
        return String(newChars)
    }
    
    //More readable, but 3x slower than
    func filterDuplicates(string: String) -> String {
        var used = [Character: Bool]()
        let filtered = string.characters.filter({
            used.updateValue(true, forKey: $0) == nil
        })
        
        return String(filtered)
    }
    
    func test() {
        assert(removeDuplicates(string: "wommbat") == "wombat")
        assert(removeDuplicatesUsingSet(string: "wommbat") == "wombat")
        assert(filterDuplicates(string: "wommbat") == "wombat")
        
        assert(removeDuplicates(string: "Mississippi") == "Misp")
        assert(removeDuplicatesUsingSet(string: "Mississippi") == "Misp")
        assert(filterDuplicates(string: "Mississippi") == "Misp")
    }
}

class StringChallenge7 {
    //Brute force.
    func condenseSpaces(string: String) -> String {
        var condensedString = ""
        var seenSpace = false
        for char in string.characters {
            if char == " " {
                if seenSpace {
                    continue
                }
                
                seenSpace = true
            } else {
                seenSpace = false
            }
            
            condensedString.append(char)
        }
        
        return condensedString
    }
    
    //50% slower than the brute force solution.
    func condenseSpacesUsingRegex(string: String) -> String {
        return string.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
    }
    
    func test() {
        assert(condenseSpaces(string: "   Hello     how are you") == " Hello how are you")
        assert(condenseSpacesUsingRegex(string: "   Hello     how are you") == " Hello how are you")
    }
}

class StringChallenge8 {
    func checkTwoStringsRotated(input: String, rotated: String) -> Bool {
        //Makes sure that even if rotated is contained in combined, that it is actually a rotation of input.
        guard input.characters.count == rotated.characters.count else {
            return false
        }
        
        //Create an entire rotation, e.g. if string1 is abcde then combined will be abcdeabcde, if the rotation is eabcd then it will exist within combined.
        let combined = input + input
        return combined.contains(rotated)
    }
    
    func test() {
        checkTwoStringsRotated(input: "abcde", rotated: "eabcd")
        assert(checkTwoStringsRotated(input: "abcde", rotated: "eabcd"))
        assert(checkTwoStringsRotated(input: "abcde", rotated: "cdeab"))
        
        assert(!checkTwoStringsRotated(input: "abcde", rotated: "abced"))
        assert(!checkTwoStringsRotated(input: "abc", rotated: "a"))
    }
}

class StringChallenge9 {
    func checkPangram(string: String) -> Bool {
        var alphabet = [String]()
        var alphString = "abcdefghijklmnopqrstuvwxyz"
        
        for char in string.characters {
            for alphChar in alphString.characters {
                if char == alphChar {
                    alphabet.append(String(char))
                }
            }
        }
        
        for char in alphString.characters {
            if !alphabet.contains(String(char)) {
                return false
            }
        }
        
        return true
    }
    
    func checkPangramWithSet(string: String) -> Bool {
        let set = Set(string.lowercased().characters)
        let letters = set.filter { $0 >= "a" && $0 <= "z" }
        return letters.count == 26
    }
    
    func test() {
        assert(checkPangram(string: "abcdefghijklmnopqrstuvwxyz"))
        assert(checkPangram(string: "The quick brown fox jumps over the lazy dog"))
        assert(!checkPangram(string: "The quick brown fox jumped over the lazy dog"))
        
        assert(checkPangramWithSet(string: "abcdefghijklmnopqrstuvwxyz"))
        assert(checkPangramWithSet(string: "The quick brown fox jumps over the lazy dog"))
        assert(!checkPangramWithSet(string: "The quick brown fox jumped over the lazy dog"))
    }
}

class StringChallenge10 {
    //MY SOLUTION USING REGEX
    func filterConsonentsAndVowels(string: String) -> (Int, Int) {
        let letters = matches(for: "[A-Za-z]", in: string)
        var vowels = 0
        var consonents = 0
        
        for letter in letters {
            if "aeiou".contains(letter) {
                vowels += 1
            } else {
                consonents += 1
            }
        }
        
        return (vowels, consonents)
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    //Character sets
    func filterUsingCharacterSets(input: String) -> (vowels: Int, consonants: Int) {
        let vowels = CharacterSet(charactersIn: "aeiou")
        let consonants = CharacterSet(charactersIn: "bcdfghjklmnpqrstvwxyz")
        
        var vowelCount = 0
        var consonantCount = 0
        
        for letter in input.lowercased().characters {
            //Annoying requirement to cast.
            let stringLetter = String(letter)
            
            if stringLetter.rangeOfCharacter(from: vowels) != nil {
                vowelCount += 1
            } else if stringLetter.rangeOfCharacter(from: consonants) != nil {
                consonantCount += 1
            }
        }
        
        return (vowelCount, consonantCount)
    }
    
    //No characters just strings
    func filterUsingStrings(input: String) -> (vowels: Int, consonants: Int) {
        let vowels = "aeiou"
        let consonants = "bcdfghjklmnpqrstvwxyz"
        
        var vowelCount = 0
        var consonantCount = 0
        
        for letter in input.lowercased().characters {
            let stringLetter = String(letter)
            if vowels.contains(stringLetter) {
                vowelCount += 1
            } else if consonants.contains(stringLetter) {
                consonantCount += 1
            }
        }
        
        return (vowelCount, consonantCount)
    }
    
    //No strings just characters and arrays
    func filterUsingArrays(input: String) -> (vowels: Int, consonants: Int) {
        let vowels = "aeiou".characters
        let consonants = "bcdfghjklmnpqrstvwxyz".characters
        
        var vowelCount = 0
        var consonantCount = 0
        
        for letter in input.lowercased().characters {
            if vowels.contains(letter) {
                vowelCount += 1
            } else if consonants.contains(letter) {
                consonantCount += 1
            }
        }
        
        return (vowelCount, consonantCount)
    }
    
    func tests() {
        let test1 = filterConsonentsAndVowels(string: "Swift Coding Challenges")
        assert(test1.0 == 6 && test1.1 == 15)
        
        let test2 = filterConsonentsAndVowels(string: "Mississippi")
        assert(test2.0 == 4 && test2.1 == 7)
    }
}

class StringChallenge11 {
    //MY SOLUTION
    func hasThreeDifferentLetters(string1: String, string2: String) -> Bool {
        guard string1.characters.count == string2.characters.count else {
            return false
        }
        
        var differentLetters = 0
        
        let array1 = Array(string1.characters)
        let array2 = Array(string2.characters)
        
        for (index, char) in array1.enumerated() {
            if char != array2[index] {
                differentLetters += 1
            }
        }
        
        return differentLetters <= 3
    }
    
    func tests() {
        assert(hasThreeDifferentLetters(string1: "Clamp", string2: "Cramp"))
        assert(hasThreeDifferentLetters(string1: "Clamp", string2: "Crams"))
        assert(hasThreeDifferentLetters(string1: "Clamp", string2: "Grams"))
        
        assert(hasThreeDifferentLetters(string1: "Clamp", string2: "Clam") == false)
        assert(hasThreeDifferentLetters(string1: "clamp", string2: "maple") == false)
    }
}

class StringChallenge12 {
    //TODO: Revise this one, I struggled with it.
    func longestPrefix(string: String) -> String {
        
        let parts = string.components(separatedBy: " ")
        guard let first = parts.first else { return "" }
        
        var currentPrefix = ""
        var bestPrefix = ""
        
        for letter in first.characters {
            currentPrefix.append(letter)
            
            for word in parts {
                if !word.hasPrefix(currentPrefix) {
                    return bestPrefix
                }
            }
            
            bestPrefix = currentPrefix
        }
        
        return bestPrefix
    }
    
    func tests() {
        assert(longestPrefix(string: "swift switch swill swim") != "swi")
        assert(longestPrefix(string: "flip flap flop") == "fl")
    }
}

class StringChallenge13 {
    //TODO: Difficult one.
    //Come back to this one, you really struggled with it.
    
    //MY SHITTY SOLUTION
    func occurences(string: String) -> String {
        var mainString = ""
        var currentIndex = 0
        
        for (index, char) in string.characters.enumerated() {
            //Skip forward if we've already started at this letter.
            if currentIndex > index || index == string.characters.count - 1 {
                continue
            }
            
            //First run of this letter, add it to the main string.
            mainString.append(char)
            var incidence = 1
            
            for (index2, char2) in string.characters.enumerated() {
                //Already added in the first loop, move on.
                if index2 <= index {
                    continue
                }
                
                //Reached the end of a letter run, break the comparison loop and update the currentChar
                if char2 != char {
                    currentIndex = index2
                    break
                }
                
                incidence += 1
            }
            
            mainString.append(String(incidence))
        }
        
        print(mainString)
        return mainString
    }
    
    //THE ACTUAL SOLUTION (using brute force)
    func occurencesBruteForce(string: String) -> String {
        var currentLetter: Character?
        var returnValue = ""
        var letterCounter = 0
        
        for letter in string.characters {
            if letter == currentLetter {
                letterCounter += 1
            } else {
                if let current = currentLetter {
                    returnValue.append("\(current)\(letterCounter)")
                }
                
                currentLetter = letter
                letterCounter = 1
            }
        }
        
        if let current = currentLetter {
            returnValue.append("\(current)\(letterCounter)")
        }
        
        return returnValue
    }
    
    //The solution using arrays - 15% slower than brute force.
    func occurencesUsingArrays(string: String) -> String {
        var returnValue = ""
        var letterCounter = 0
        var letterArray = Array(string.characters)
        
        for i in 0 ..< letterArray.count {
            letterCounter += 1
            
            if i + 1 == letterArray.count || letterArray[i] != letterArray[i + 1] {
                returnValue += "\(letterArray[i])\(letterCounter)"
                letterCounter = 0
            }
        }
        
        return returnValue
    }
    
    func tests() {
        assert(occurencesBruteForce(string: "aabbcc") == "a2b2c2")
        assert(occurencesBruteForce(string: "aaabaaabaaa") == "a3b1a3b1a3")
        assert(occurencesBruteForce(string: "aaAAaa") == "a2A2a2")
        
        assert(occurencesUsingArrays(string: "aabbcc") == "a2b2c2")
        assert(occurencesUsingArrays(string: "aaabaaabaaa") == "a3b1a3b1a3")
        assert(occurencesUsingArrays(string: "aaAAaa") == "a2A2a2")
    }
}

class StringChallenge14 {
    //TODO: Difficult one.
    //REALLY STRUGGLED WITH THIS ONE. Joe did me a diagram look in personal folder.
    func challenge14(string: String, current: String = "", loopIndex: Int = -1) {
        let length = string.characters.count
        let strArray = Array(string.characters)
        
        print("Recursion called with string \(string) and current: \(current == "" ? "Nothing" : current) and loopIndex \(loopIndex)")
        
        if (length == 0) {
            // there's nothing left to re-arrange; print the result
            print("TERMINATING WITH: \(current)")
            print("******")
        } else {
            // loop through every character
            for i in 0 ..< length {
                print("Loop started with string \(string) and current \(current)")
                // get the letters before me
                let left = String(strArray[0 ..< i])
                
                // get the letters after me
                let right = String(strArray[i+1 ..< length])
                print(strArray)
                print("INDEX: \(i)  \nLEFT: \(left)  \nRIGHT: \(right)  \nCURRENT: \(current + String(strArray[i]))\n---")
                
                // put those two together and carry on
                challenge14(string: left + right, current: current + String(strArray[i]), loopIndex: i)
            }
        }
    }
}

class StringChallenge15 {
    func reverseComponents(string: String) -> String {
        let components = string.components(separatedBy: " ").map({
            String($0.characters.reversed())
        })
        
        return components.joined(separator: " ")
    }
    
    func tests() {
        assert(reverseComponents(string: "Swift Coding Challenges") == "tfiwS gnidoC segnellahC")
        assert(reverseComponents(string: "The quick brown fox") == "ehT kciuq nworb xof")
    }
}
