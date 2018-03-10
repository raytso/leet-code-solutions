//
//  787_CheapestFlightsWithinKStops.swift
//  
//
//  Created by Ray Tso on 10/03/2018.
//

import Foundation

class Airport {
    var index: Int
    var connections: [Int: Int] = [:]
    
    init(index: Int) {
        self.index = index
    }
}

class Solution {
    private var airports: [Int: Airport] = [:]
    private var destination: Airport!
    private var limit: Int = 0
    private var heap: Heap!
    
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
        setupConnections(flights)
        guard let start = airports[src], let destination = airports[dst] else { return -1 }
        self.limit = K
        self.destination = destination
        self.heap = Heap(elements: [(cost: 0, port: start, stops: 0)], priorityType: <)
        return mapRoute()
    }
    
    private func mapRoute() -> Int {
        while !heap.isEmpty {
            let trip = heap.pop()!
            
            guard trip.port.index != destination.index else { return trip.cost }
            
            guard trip.stops <= limit else { continue }
            
            trip.port.connections.forEach { (nextPortIndex, cost) in
                heap.push((cost: trip.cost + cost, port: airports[nextPortIndex]!, stops: trip.stops + 1))
            }
        }
        return -1
    }
    
    private func setupConnections(_ flights: [[Int]]) {
        flights.forEach {
            let start: Airport
            let destination: Airport
            
            if let port = airports[$0[0]] {
                start = port
            } else {
                start = Airport(index: $0[0])
                airports[$0[0]] = start
            }
            
            if let port = airports[$0[1]] {
                destination = port
            } else {
                destination = Airport(index: $0[1])
                airports[$0[1]] = destination
            }
            start.connections[destination.index] = $0[2]
        }
    }
}

struct Heap {
    var elements: [(cost: Int, port: Airport, stops: Int)]
    let priorityType: (Int, Int) -> Bool
    
    init(elements: [(cost: Int, port: Airport, stops: Int)] = [], priorityType: @escaping (Int, Int) -> Bool) {
        self.elements = elements
        self.priorityType = priorityType
        buildHeap()
    }
    
    mutating func buildHeap() {
        for index in (0 ..< count / 2).reversed() {
            siftDown(elementAtIndex: index)
        }
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> (cost: Int, port: Airport, stops: Int)? {
        return elements.first
    }
    
    mutating func push(_ element: (cost: Int, port: Airport, stops: Int)) {
        elements.append(element)
        siftUp(elementAtIndex: count - 1)
    }
    
    mutating func siftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)
        guard !isRoot(index), isHigherPriority(at: index, than: parent) else { return }
        swapElement(at: index, with: parent)
        siftUp(elementAtIndex: parent)
    }
    
    mutating func pop() -> (cost: Int, port: Airport, stops: Int)? {
        guard !isEmpty else { return nil }
        swapElement(at: 0, with: count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            siftDown(elementAtIndex: 0)
        }
        return element
    }
    
    mutating func siftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex {
            return
        }
        swapElement(at: index, with: childIndex)
        siftDown(elementAtIndex: childIndex)
    }
    
    func isRoot(_ index: Int) -> Bool {
        return (index == 0)
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityType(elements[firstIndex].cost, elements[secondIndex].cost)
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriority(at: childIndex, than: parentIndex) else { return parentIndex }
        return childIndex
    }
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent,
                                                             and: leftChildIndex(of: parent)),
                                    and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
}
