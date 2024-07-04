//
//  SettingsViewModel.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI

protocol SettingsViewModelDelegate: AnyObject {
    func didSaveTestResult(_ result: TestResult)
}

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var startTime: Int = 0
    @Published var endTime: Int = 0
    @Published var targetTime: Int = 0
    @Published var error: TimeRangeError?
    
    weak var delegate: SettingsViewModelDelegate?

    private let repository: TestResultRepositoryInterface
    
    init(repository: TestResultRepositoryInterface = TestResultRepository()) {
        self.repository = repository
    }
    
    func judgeAndSaveResult() throws {
        guard let timeRange = TimeRange(start: startTime, end: endTime),
              let result = TestResult(timeRange: timeRange, target: targetTime) else {
            throw TimeRangeError.invalid
        }
        
        repository.saveResult(result)
        delegate?.didSaveTestResult(result)
    }
}
