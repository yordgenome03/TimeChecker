//
//  TestResult.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct TestResult: Identifiable, Hashable, Codable {
    var id = UUID()
    let timeRange: TimeRange
    let target: Int
    let isContained: Bool
    
    init?(timeRange: TimeRange, target: Int) {
        self.timeRange = timeRange
        self.target = target
        
        guard let contains = try? timeRange.contains(target) else {
            return nil
        }
        self.isContained = contains
    }
}

extension TestResult {
    static let mockArray: [TestResult] = [
        .init(timeRange: .mock_eightToSixteen, target: 1)!,
        .init(timeRange: .mock_eightToSixteen, target: 10)!,
        .init(timeRange: .mock_eightToSixteen, target: 16)!,
        .init(timeRange: .mock_eightToSixteen, target: 23)!,
        .init(timeRange: .mock_zeroToZero, target: 0)!,
        .init(timeRange: .mock_zeroToZero, target: 1)!,
        .init(timeRange: .mock_zeroToZero, target: 23)!,
        .init(timeRange: .mock_sixteenToEight, target: 9)!,
        .init(timeRange: .mock_sixteenToEight, target: 16)!,
        .init(timeRange: .mock_sixteenToEight, target: 5)!,
        .init(timeRange: .mock_sixteenToEight, target: 8)!,
    ]
}

