//
//  771_JewelsStones.swift
//  
//
//  Created by Ray Tso on 02/03/2018.
//

import Foundation

class Solution {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        var jewels: [String: Int] = [:]
        
        J.forEach { jewels["\($0)"] = 0 }
        
        S.forEach { char in
            guard let count = jewels["\(char)"] else { return }
            jewels["\(char)"] = count + 1
        }
        
        return jewels.reduce(0, { $0 + $1.value })
    }
}
