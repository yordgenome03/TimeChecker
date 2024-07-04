//
//  SettingsViewModel.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

protocol SettingsViewModelDelegate: AnyObject {
    func didSaveTestResult(_ result: TimeCheckResult)
}

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var startTime: Int = 0
    @Published var endTime: Int = 0
    @Published var targetTime: Int = 0
    @Published var error: TimeRangeError?
    
    weak var delegate: SettingsViewModelDelegate?

    private let repository: TimeCheckResultRepositoryInterface
    
    init(repository: TimeCheckResultRepositoryInterface = TimeCheckResultRepository()) {
        self.repository = repository
    }
    
    func judgeAndSaveResult() throws {
        guard let timeRange = TimeRange(start: startTime, end: endTime),
              let result = TimeCheckResult(timeRange: timeRange, target: targetTime) else {
            throw TimeRangeError.invalid
        }
        
        repository.saveResult(result)
        delegate?.didSaveTestResult(result)
    }
}
