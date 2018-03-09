//
//  657_JudgeRouteCircle.swift
//  
//
//  Created by Ray Tso on 09/03/2018.
//

import Foundation

class Solution {
    private var up: Int = 0
    private var left: Int = 0
    
    func judgeCircle(_ moves: String) -> Bool {
        guard !moves.isEmpty else { return true }
        
        moves.lowercased().forEach {
            switch $0 {
            case "u":
                up += 1
            case "d":
                up -= 1
            case "l":
                left += 1
            case "r":
                left -= 1
            default: break
            }
        }
        
        return (up == 0 && left == 0)
    }
}
