//
//  TimeRangeError.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import Foundation

enum TimeRangeError: Error, CustomStringConvertible {
    case invalid
    
    var description: String {
        switch self {
        case .invalid:
            return "時刻は0以上23以下の整数を指定してください。"
        }
    }
}

