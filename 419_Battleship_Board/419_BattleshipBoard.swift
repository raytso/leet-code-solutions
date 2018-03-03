//
//  419_BattleshipBoard.swift
//  
//
//  Created by Ray Tso on 04/03/2018.
//

import Foundation

class Solution {
    private var shipCount: Int = 0
    private var board: [[Character]] = []
    private var ships: Set<Int> = []
    private enum Direction {
        case right
        case down
    }
    
    func countBattleships(_ board: [[Character]]) -> Int {
        self.board = board
        print(board)
        for row in 0..<board.count {
            for col in 0..<board[0].count {
                let index = (row * board[0].count + col)
                if isShip(char: board[row][col]) && isNewShip(at: index) {
                    ships.insert(index)
                    shipCount += 1
                    check(row: row, col: col + 1, .right)
                    check(row: row + 1, col: col, .down)
                }
            }
        }
        return shipCount
    }
    
    private func check(row: Int, col: Int, _ direction: Direction) {
        guard row < board.count && col < board[0].count else { return }
        let index = (row * board[0].count + col)
        if isShip(char: board[row][col]) {
            ships.insert(index)
            switch direction {
            case .right:
                check(row: row, col: (col + 1), direction)
            case .down:
                check(row: (row + 1), col: col, direction)
            }
        }
    }
    
    private func isNewShip(at index: Int) -> Bool {
        return !ships.contains(index)
    }
    
    private func isShip(char: Character) -> Bool {
        return ("\(char)" == "X")
    }
    
}
