//
//  TimeRange.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct TimeRange: Hashable {
    let start: Int
    let end: Int
    
    init?(start: Int, end: Int) {
        guard (0...23).contains(start),
              (0...23).contains(end) else {
            return nil
        }
        self.start = start
        self.end = end
    }
    
    func contains(_ time: Int) throws -> Bool {
        guard (0...23).contains(time) else {
            throw TimeRangeError.invalid
        }
        
        if start == end {
            return time == start
        } else if start < end {
            return time >= start && time < end
        } else {
            return time >= start || time < end
        }
    }
}

extension TimeRange {
    static let mock_eightToSixteen: TimeRange = .init(start: 8, end: 16)!
    static let mock_sixteenToEight: TimeRange = .init(start: 16, end: 8)!
    static let mock_zeroToZero: TimeRange = .init(start: 0, end: 0)!
}
