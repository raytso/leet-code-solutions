//
//  781_RabbitForest.swift
//  
//
//  Created by Ray Tso on 09/03/2018.
//

import Foundation

class Solution {
    private var counter: [Int: Int] = [:]
    private var total: Int = 0
    
    func numRabbits(_ answers: [Int]) -> Int {
        answers.forEach { self.count(type: $0) }
        return counter.keys.reduce(total, { $0 + ($1 + 1) })
    }
    
    private func count(type: Int) {
        if var count = counter[type] {
            count -= 1
            counter[type] = count
        } else {
            counter[type] = type + 1
        }
        if let count = counter[type], count <= 1 {
            counter.removeValue(forKey: type)
            total += (type + 1)
        }
    }
}
