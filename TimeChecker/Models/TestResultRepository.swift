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
    func deleteResults(_ results: [TestResult])
    func deleteAllResults()
}

class TestResultRepository: TestResultRepositoryInterface {
    private let service = UserDefaultsService()
    
    func saveResult(_ result: TestResult) {
        var results = service.fetchResults()
        results.insert(result, at: 0)
        service.save(results: results)
    }
    
    func fetchResults() -> [TestResult] {
        return service.fetchResults()
    }
    
    func deleteResults(_ results: [TestResult]) {
        service.delete(results: results)
    }
    
    func deleteAllResults() {
        service.deleteAllResults()
    }
}
