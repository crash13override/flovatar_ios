//
//  Extension+Array.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 04.01.2022.
//

import Foundation

extension Array {
    func breakInto(piecesOf: UInt, trimTail: Bool = false) -> [[Element]] {
        var resultArray: [[Element]] = []
        var tempArray: [Element] = []
        
        for (index, value) in self.enumerated() {
            if tempArray.count == piecesOf {
                resultArray.append(tempArray)
                tempArray.removeAll()
                tempArray.append(value)
                
                if !trimTail && index == self.count - 1 {
                    resultArray.append(tempArray)
                }
            } else {
                tempArray.append(value)
                
                if !trimTail && index == self.count - 1 {
                    resultArray.append(tempArray)
                }
            }
        }
        
        return resultArray
    }
    
    func cutArray(forCount: Int) -> [Element] {
        var resultArray: [Element] = []

        if forCount <= count {
            for item in 0..<forCount {
                resultArray.append(self[item])
            }
        } else {
            print(#fileID, #line, "‼️Error: forCount bigger than Array count")
        }

        return resultArray
    }
    
    
    // MARK: - Custom Random Generator
    static func generateRandomUniqueNumbers(inRange: ClosedRange<Int>, numbersCount: Int) -> [Int] {
        guard numbersCount <= inRange.upperBound else { return [] }
        
        var numbers: Set<Int> = []
        
        (0..<numbersCount).forEach { _ in
            let beforeCount = numbers.count
            
            repeat {
                numbers.insert(randomNumber(between: inRange.lowerBound, and: inRange.upperBound))
            } while numbers.count == beforeCount
        }
        
        return numbers.map{ $0 }
    }
    
    static private func randomNumber(between lower: Int, and upper: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper - lower))) + lower
    }
}
