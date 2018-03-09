//
//  791_CustomSortString.swift
//  
//
//  Created by Ray Tso on 09/03/2018.
//

import Foundation

class Solution {
    private var characterSet: [String: Int] = [:] // (char: order)
    private var outputArray: [(String, Int)] = [] // (char: count)
    private var output = ""
    
    func customSortString(_ S: String, _ T: String) -> String {
        S.enumerated().forEach { characterSet["\($0.element)"] = $0.offset }
        outputArray = Array(repeating: ("", 0), count: characterSet.count)
        T.forEach { char in
            let letter = "\(char)"
            if let index = characterSet[letter] {
                var (_, count) = outputArray[index]
                count += 1
                outputArray[index] = (letter, count)
            } else {
                output += letter
            }
        }
        return outputArray.reduce(output, { $0 + String(repeating: $1.0, count: $1.1) })
    }
}
