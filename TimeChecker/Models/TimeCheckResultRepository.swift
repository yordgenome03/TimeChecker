//
//  TimeCheckResultRepository.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import Foundation

protocol TimeCheckResultRepositoryInterface {
    func saveResult(_ result: TimeCheckResult)
    func fetchResults() -> [TimeCheckResult]
    func deleteResults(_ results: [TimeCheckResult])
    func deleteAllResults()
}

class TimeCheckResultRepository: TimeCheckResultRepositoryInterface {
    private let service = UserDefaultsService()
    
    func saveResult(_ result: TimeCheckResult) {
        var results = service.fetchResults()
        results.insert(result, at: 0)
        service.save(results: results)
    }
    
    func fetchResults() -> [TimeCheckResult] {
        return service.fetchResults()
    }
    
    func deleteResults(_ results: [TimeCheckResult]) {
        service.delete(results: results)
    }
    
    func deleteAllResults() {
        service.deleteAllResults()
    }
}
