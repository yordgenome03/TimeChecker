//
//  TestResultRepository.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import Foundation

protocol TestResultRepositoryInterface {
    func saveResult(_ result: TestResult)
    func fetchResults() -> [TestResult]
}

class TestResultRepository: TestResultRepositoryInterface {
    private let service = UserDefaultsService()
    
    func saveResult(_ result: TestResult) {
        var results = service.fetch()
        results.insert(result, at: 0)
        service.save(results: results)
    }
    
    func fetchResults() -> [TestResult] {
        return service.fetch()
    }
}
