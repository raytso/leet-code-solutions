//
//  36_ValidSudoku.swift
//  
//
//  Created by Ray Tso on 21/03/2018.
//

import Foundation

class Solution {
    private var verticalMaps: [Set<Character>]
    private var horizontalMaps: [Set<Character>]
    private var blockMaps: [Set<Character>]
    
    init() {
        let set: Set<Character> = []
        self.verticalMaps = Array(repeating: set, count: 9)
        self.horizontalMaps = Array(repeating: set, count: 9)
        self.blockMaps = Array(repeating: set, count: 9)
    }
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        for row in board.enumerated() {
            for col in row.element.enumerated() {
                guard col.element != "." else { continue }
                let hIndex = row.offset
                let vIndex = col.offset
                let bIndex = Int(hIndex / 3) * 3 + Int(vIndex / 3)
                guard
                    !horizontalMaps[hIndex].contains(col.element),
                    !verticalMaps[vIndex].contains(col.element),
                    !blockMaps[bIndex].contains(col.element) else { return false }
                horizontalMaps[hIndex].insert(col.element)
                verticalMaps[vIndex].insert(col.element)
                blockMaps[bIndex].insert(col.element)
            }
        }
        return true
    }
}
