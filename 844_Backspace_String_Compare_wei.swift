//
//  844_Backspace_String_Compare_wei.swift
//  
//
//  Created by Wei on 2019/2/19.
//

import Foundation
class Solution {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        return removeBackspace(S) == removeBackspace(T)
    }
    
    func removeBackspace(_ s: String) -> String{
        return s.reduce(into: "") { (r, c) in
            switch c {
            case _ where c != "#":
                r.append(c)
            case "#" where r.count > 0:
                _ = r.removeLast()
            default:
                break
            }
        }
    }
}