//
//  765_CoupleHoldingHands.swift
//  
//
//  Created by Ray Tso on 01/03/2018.
//

import Foundation

class Solution {
    private var maximumSwaps: Int = 0
    
    func minSwapsCouples(_ row: [Int]) -> Int {
        maximumSwaps = row.count / 2 - 1
        return swapCouples(row)
    }
    
    private func swapCouples(_ row: [Int]) -> Int {
        guard row.count > 2 else { return maximumSwaps }
        var copyRow = row
        if checkIsCouple(a: copyRow.count - 2, b: copyRow.count - 1, arr: copyRow) {
            maximumSwaps -= 1
        } else {
            guard let index = getCoupleIndex(of: copyRow.count - 2, arr: copyRow) else { return 0 }
            let newRow = Array(swap(a: copyRow.count - 1, b: index, arr: copyRow))
            let pairIndex = (index % 2 == 0 ) ? (index, index + 1) : (index - 1, index)
            if checkIsCouple(a: pairIndex.0, b: pairIndex.1, arr: newRow) {
                if newRow.count != 4 {
                    maximumSwaps -= 1
                }
                copyRow = Array(newRow.prefix(upTo: pairIndex.0)) + Array(newRow[(pairIndex.1 + 1)...])
            } else {
                copyRow = newRow
            }
        }
        return swapCouples(Array(copyRow.dropLast(2)))
    }
    
    private func getCoupleIndex(of index: Int, arr: [Int]) -> Int? {
        let target: Int = {
            if arr[index] % 2 == 0 {
                return arr[index] + 1
            } else {
                return arr[index] - 1
            }
        }()
        for num in arr.enumerated() {
            if num.element == target {
                return num.offset
            }
        }
        return nil
    }
    
    private func swap(a: Int, b: Int, arr: [Int]) -> [Int] {
        var copyArr = arr
        let c = copyArr[a]
        copyArr[a] = copyArr[b]
        copyArr[b] = c
        return copyArr
    }
    
    private func checkIsCouple(a: Int, b: Int, arr: [Int]) -> Bool {
        if arr[a] % 2 == 0 {
            return arr[b] == arr[a] + 1
        } else {
            return arr[b] == arr[a] - 1
        }
    }

}
