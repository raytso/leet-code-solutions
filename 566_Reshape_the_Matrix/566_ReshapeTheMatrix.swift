//
//  566_ReshapeTheMatrix.swift
//  
//
//  Created by Ray Tso on 13/03/2018.
//

import Foundation

class Solution {
    func matrixReshape(_ nums: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
        let total = nums.count * nums[0].count
        let desiredTotal = r * c
        guard desiredTotal == total else { return nums }
        var output: [[Int]] = []
        var row: [Int] = []
        var count = 1
        nums.forEach {
            $0.forEach { num in
                row.append(num)
                if count == c {
                    output.append(row)
                    row = []
                    count = 1
                    return
                }
                count += 1
            }
        }
        return output
    }
}
