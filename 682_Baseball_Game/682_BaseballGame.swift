//
//  682_BaseballGame.swift
//  
//
//  Created by Ray Tso on 12/03/2018.
//

import Foundation

class Solution {
    func calPoints(_ ops: [String]) -> Int {
        var scoreLog: [Int] = []
        ops.forEach { input in
            switch input {
            case "+":
                var sum = 0
                if let last = scoreLog.last {
                    sum += last
                }
                if scoreLog.count - 2 >= 0 {
                    sum += scoreLog[scoreLog.count - 2]
                }
                scoreLog.append(sum)
            case "D":
                if let last = scoreLog.last {
                    scoreLog.append(last * 2)
                }
            case "C":
                if scoreLog.last != nil {
                    _ = scoreLog.removeLast()
                }
            default:
                scoreLog.append(Int(input)!)
            }
        }
        return scoreLog.reduce(0, +)
    }
}
