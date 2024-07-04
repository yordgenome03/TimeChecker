//
//  UserDefaultsServiceTests.swift
//  TimeCheckerTests
//
//  Created by yotahara on 2024/07/04.
//

import XCTest
@testable import TimeChecker

final class UserDefaultsServiceTests: XCTestCase {
    
    var backUpResults: [TimeCheckResult]?
    var service: UserDefaultsService!
    
    override func setUpWithError() throws {
        if let data = UserDefaults.standard.data(forKey: Keys.timeCheckResults),
           let results = try? JSONDecoder().decode([TimeCheckResult].self, from: data) {
            backUpResults = results
            
            removeSavedResults()
        }
        
        service = UserDefaultsService()
    }
    
    override func tearDownWithError() throws {
        removeSavedResults()
        
        if let backUpResults {
            if let data = try? JSONEncoder().encode(backUpResults) {
                UserDefaults.standard.set(data, forKey: Keys.timeCheckResults)
            }
        }
        
        backUpResults = nil
        service = nil
    }
    
    private func removeSavedResults() {
        UserDefaults.standard.removeObject(forKey: Keys.timeCheckResults)
    }
    
    
    func testSaveAndFetchAndDeleteResults() {
        let initialResults = service.fetchResults()
        XCTAssertTrue(initialResults.isEmpty)
        
        let newResults = TimeCheckResult.mockArray
        service.save(results: newResults)
        let fetchedNewResults = service.fetchResults()
        XCTAssertEqual(fetchedNewResults, newResults)
        
        let firstResult = newResults[0]
        let secondResult = newResults[1]
        service.delete(results: [firstResult, secondResult])
        let fetchedDeletedResults = service.fetchResults()
        XCTAssertEqual(fetchedDeletedResults.count, newResults.count - 2)
        let updatedResults = newResults
            .filter { $0.id != firstResult.id && $0.id != secondResult.id }
        XCTAssertEqual(fetchedDeletedResults, updatedResults)
    }
    
    func testDeleteAllResults() {
        let initialResults = service.fetchResults()
        XCTAssertTrue(initialResults.isEmpty)
        
        let newResults = TimeCheckResult.mockArray
        service.save(results: newResults)
        let fetchedNewResults = service.fetchResults()
        XCTAssertEqual(fetchedNewResults, newResults)
        
        service.deleteAllResults()
        let fetchedDeletedResults = service.fetchResults()
        XCTAssertTrue(fetchedDeletedResults.isEmpty)
    }
}
