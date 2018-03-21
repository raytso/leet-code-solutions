//
//  40_CombinationSum2.swift
//  
//
//  Created by Ray Tso on 21/03/2018.
//

import Foundation

class Solution {
    var candidates: [Int] = []
    var result: [[Int]] = []
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        guard candidates.count > 0 else { return [] }
        self.candidates = candidates
        combinationSum(target: target, temp: [], threshold: 0)
        return result
    }
    
    private func combinationSum(target: Int, temp: [Int], threshold: Int) {
        guard target >= 0 else { return }
        if target == 0 {
            result.append(temp)
            return
        }
        var temp = temp
        for index in threshold..<candidates.count {
            let candidate = candidates[index]
            guard index <= threshold || candidates[index - 1] != candidate else { continue }
            temp.append(candidate)
            combinationSum(target: (target - candidate), temp: temp, threshold: index + 1)
            temp.popLast()
        }
        return
    }
}
