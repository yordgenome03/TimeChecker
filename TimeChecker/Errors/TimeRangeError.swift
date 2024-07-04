//
//  TimeRangeError.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import Foundation

enum TimeRangeError: Error, CustomStringConvertible, Identifiable {
    var id: Int { hashValue }
    
    case invalid
    case unknown
    
    var description: String {
        switch self {
        case .invalid:
            return "時刻は0以上23以下の整数を指定してください。"
        case .unknown:
            return "エラー発生しました。"
        }
    }
}

