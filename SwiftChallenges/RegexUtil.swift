//
//  RegexUtil.swift
//  SwiftChallenges
//
//  Created by Matt Beaney on 23/12/2016.
//  Copyright © 2016 Matt Beaney. All rights reserved.
//

import Foundation

class RegexUtil {
    static func matches(for regex: String, in text: String) -> [String] {
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
}
