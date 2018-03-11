//
//  347_TopKFrequentElements.swift
//  
//
//  Created by Ray Tso on 11/03/2018.
//

import Foundation

class Solution {
    private var maxHeap: Heap<Int> = Heap(elements: [], priorityType: >)
    private var counter: [Int: Int] = [:]
    
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var output: [Int] = []
        nums.forEach {
            guard var count = counter[$0] else {
                counter[$0] = 1
                return
            }
            count += 1
            counter[$0] = count
        }
        counter.forEach {
            maxHeap.push((item: $0.key, priority: $0.value))
        }
        
        for _ in 0..<k {
            guard let item = maxHeap.pop()?.item else { continue }
            output.append(item)
        }
        
        return output
    }
}
