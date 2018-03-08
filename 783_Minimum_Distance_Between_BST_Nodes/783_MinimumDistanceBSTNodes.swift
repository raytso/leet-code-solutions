//
//  783_MinimumDistanceBSTNodes.swift
//  
//
//  Created by Ray Tso on 09/03/2018.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

class Solution {
    var minimum: Int = Int.max
    var prev: Int?
    
    func minDiffInBST(_ root: TreeNode?) -> Int {
        guard let root = root else { return minimum }
        inOrder(root)
        return minimum
    }
    
    private func inOrder(_ root: TreeNode) {
        if let leftNode = root.left {
            _ = inOrder(leftNode)
        }
        if prev != nil {
            minimum = min(abs(root.val - prev!), minimum)
        }
        prev = root.val
        if let rightNode = root.right {
            _ = inOrder(rightNode)
        }
    }
}

