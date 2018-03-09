//
//  442_FindAllDuplicates.swift
//  
//
//  Created by Ray Tso on 09/03/2018.
//

import Foundation

class Solution {
    private var output: [Int] = []
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var mutableNums = nums
        nums.forEach { num in
            if mutableNums[num - 1] < 0 {
                output.append(num)
            } else {
                mutableNums[num - 1] = -mutableNums[num - 1]
            }
        }
        return output
    }
}
