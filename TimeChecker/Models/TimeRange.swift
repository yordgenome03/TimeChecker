//
//  TimeRange.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

struct TimeRange {
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
