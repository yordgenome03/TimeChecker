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
    
    init(start: Int, end: Int) {
        self.start = start
        self.end = end
    }
    
    func contains(_ time: Int) -> Bool {
        if start == end {
            return time == start
        } else if start < end {
            return time >= start && time < end
        } else {
            return time >= start || time < end
        }
    }
}
