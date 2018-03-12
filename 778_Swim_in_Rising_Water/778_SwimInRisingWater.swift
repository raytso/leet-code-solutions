//
//  778_SwimInRisingWater.swift
//  
//
//  Created by Ray Tso on 12/03/2018.
//

import Foundation

struct Position {
    let row: Int
    let col: Int
    private let const: Int
    var rawValue: Int {
        return row * const + col
    }
    var neighBors: [Position] {
        return [Position(row: self.row, col: self.col + 1, const: const),
                Position(row: self.row + 1, col: self.col, const: const),
                Position(row: self.row, col: self.col - 1, const: const),
                Position(row: self.row - 1, col: self.col, const: const)]
    }
    
    init(row: Int, col: Int, const: Int) {
        self.row = row
        self.col = col
        self.const = const
    }
}


class Solution {
    private var minHeap: Heap<Position> = Heap(elements: [], priorityType: <)
    private var destination: Position!
    private var lowestElevation: Int = 0
    private var visited: Set<Int> = []
    private var touched: Set<Int> = []
    private var map: [[Int]]!
    private var rowsLimit: Int = 0
    private var colsLimit: Int = 0
    
    func swimInWater(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty && !grid[0].isEmpty else { return 0 }
        setupMap(grid)
        destination = Position(row: (grid.count - 1), col: (grid[0].count - 1), const: colsLimit + 1)
        minHeap.push((item: Position(row: 0, col: 0, const: colsLimit + 1), priority: self.map[0][0]))
        
        while !minHeap.isEmpty {
            let current = minHeap.pop()!
            if current.priority > lowestElevation {
                lowestElevation = current.priority
            }
            visited.insert(current.item.rawValue)
            guard current.item.rawValue != destination.rawValue else { return lowestElevation }
            validate(current.item)
        }
        return -1
    }
    
    private func setupMap(_ grid: [[Int]]) {
        self.map = grid
        self.rowsLimit = grid.count - 1
        self.colsLimit = grid[0].count - 1
    }
    
    private func validate(_ position: Position) {
        let valid = validNeighbors(position)
        valid.forEach {
            guard !touched.contains($0.rawValue) else { return }
            self.minHeap.push((item: $0, priority: self.map[$0.row][$0.col]))
            touched.insert($0.rawValue)
        }
        
    }
    
    private func validNeighbors(_ position: Position) -> [Position] {
        return position.neighBors.filter { isWithinBounds($0) && !visited.contains($0.rawValue) }
    }
    
    private func isWithinBounds(_ position: Position) -> Bool {
        guard position.row >= 0 && position.col >= 0 else { return false }
        return position.row <= rowsLimit && position.col <= colsLimit
    }
}
