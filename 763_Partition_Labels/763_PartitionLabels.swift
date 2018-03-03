//
//  763_PartitionLabels.swift
//  
//
//  Created by Ray Tso on 03/03/2018.
//

import Foundation

class Solution {
    private var startIndexDict: [String: Int] = [:]
    private var partitionStartingStringIndex: [String: Int] = [:]
    private var partitions: [[String]] = []
    private var currentLow: Int = 0
    
    func partitionLabels(_ S: String) -> [Int] {
        S.enumerated().forEach { [weak self] (index, char) in
            let letter = "\(char)"
            if let oldIndex = startIndexDict[letter] {
                if oldIndex >= currentLow {
                    var last = partitions.popLast()
                    last!.append(letter)
                    partitions.append(last!)
                } else {
                    currentLow = oldIndex
                    var mergePoint = partitionStartingStringIndex[letter] as! Int
                    mergePartition(for: letter, after: mergePoint)
                }
            } else {
                startIndexDict[letter] = index
                partitions.append([letter])
                partitionStartingStringIndex[letter] = partitions.count - 1
                currentLow = index
            }
        }
        return partitions.map { $0.count }
    }
    
    private func mergePartition(for letter: String, after index: Int) {
        var saved: [[String]] = []
        var merged: [String] = []
        if index != 0 {
            saved = Array(partitions[0...(index - 1)])
        }
        merged = Array(partitions[index...].flatMap { $0 })
        merged.forEach { s in
            if saved.isEmpty {
                partitionStartingStringIndex[s] = 0
            } else {
                partitionStartingStringIndex[s] = saved.count
            }
        }
        merged.append(letter)
        saved.append(merged)
        partitions = saved
    }
    
    private func updateRange(for char: String, at index: Int) {
        startIndexDict[char] = startIndexDict[char] ?? index
    }
}
