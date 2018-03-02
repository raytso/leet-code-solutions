//
//  784_LetterCasePermutation.swift
//  
//
//  Created by Ray Tso on 02/03/2018.
//

import Foundation

class Solution {
    private var output: [String] = []
    private var lowercaseLetters = NSCharacterSet.lowercaseLetters
    
    func letterCasePermutation(_ S: String) -> [String] {
        let text = S.lowercased()
        var stringCache: String = ""
        output.append("")
        for char in text {
            guard let uniChar = char.unicodeScalars.first else { continue }
            if lowercaseLetters.contains(uniChar) {
                var arr: [String] = []
                output.forEach { word in
                    let a = word + stringCache + "\(char)"
                    let b = word + stringCache + "\(char)".uppercased()
                    arr.append(a)
                    arr.append(b)
                }
                stringCache = ""
                output = arr
            } else {
                stringCache += "\(char)"
            }
        }
        return output.map { $0 + stringCache }
    }
}
