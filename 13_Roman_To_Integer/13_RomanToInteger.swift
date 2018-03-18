//
//  13_RomanToInteger.swift
//  
//
//  Created by Ray Tso on 18/03/2018.
//

import Foundation

class Solution {
    private enum RomanCharacter: Int {
        case I = 1
        case V = 5
        case X = 10
        case L = 50
        case C = 100
        case D = 500
        case M = 1000
    }
    
    private let dict: [String: RomanCharacter] = ["I": .I,
                                                  "V": .V,
                                                  "X": .X,
                                                  "L": .L,
                                                  "C": .C,
                                                  "D": .D,
                                                  "M": .M]
    
    func romanToInt(_ s: String) -> Int {
        return s
            .flatMap { dict["\($0)"]?.rawValue }
            .reduceByTwo(0, {
                if $1 < $2 {
                    return $0 - $1
                } else {
                    return $0 + $1
                }
            }) ?? dict[s]?.rawValue ?? -1
    }
}

private extension Array where Element == Int {
    func reduceByTwo(_ total: Int, _ next: (_ sum: inout Int, _ current: Int, _ next: Int) -> Int) -> Int? {
        guard self.count > 1 else { return nil }
        var initalSum = total
        for current in self.enumerated() {
            guard current.offset < self.count - 1 else {
                initalSum = next(&initalSum, current.element, 0)
                continue
            }
            initalSum = next(&initalSum, current.element, self[current.offset + 1])
        }
        return initalSum
    }
}
