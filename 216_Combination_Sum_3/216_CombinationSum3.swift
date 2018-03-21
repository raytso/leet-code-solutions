//
//  216_CombinationSum3.swift
//  
//
//  Created by Ray Tso on 21/03/2018.
//

import Foundation

class Solution {
    var candidates: [Int] = Array(1...9)
    var limit: Int = 0
    var result: [[Int]] = []
    
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        self.limit = k
        combinationSum(target: n, temp: [], threshold: 0)
        return result
    }
    
    private func combinationSum(target: Int, temp: [Int], threshold: Int) {
        guard target >= 0 else { return }
        if target == 0 && limit == 0 {
            result.append(temp)
            return
        }
        guard limit > 0 else { return }
        for index in threshold..<9 {
            let candidate = candidates[index]
            guard index <= threshold || candidates[index - 1] != candidate else { continue }
            var temp = temp
            temp.append(candidate)
            self.limit -= 1
            combinationSum(target: (target - candidate), temp: temp, threshold: index + 1)
            self.limit += 1
        }
        return
    }
}
