//
//  39_CombinationSum.swift
//  
//
//  Created by Ray Tso on 21/03/2018.
//

import Foundation

class Solution {
    private var combinations: [[Int]] = []
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        combinationSum(cand: candidates, target: target, result: [])
        return combinations
    }
    
    private func combinationSum(cand: [Int], target: Int, result: [Int]) {
        guard target > 0 else { return }
        var temp = result
        var candidates = cand
        while !candidates.isEmpty {
            guard let largestCandidate = candidates.last else { break }
            if largestCandidate == target {
                temp.append(largestCandidate)
                combinations.append(temp)
                temp.popLast()
            } else if target > largestCandidate {
                temp.append(largestCandidate)
                combinationSum(cand: candidates, target: target - largestCandidate, result: temp)
                temp.popLast()
            }
            candidates.popLast()
        }
        return
    }
}
