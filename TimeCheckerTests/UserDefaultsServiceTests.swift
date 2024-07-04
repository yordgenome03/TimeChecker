//
//  UserDefaultsServiceTests.swift
//  TimeCheckerTests
//
//  Created by yotahara on 2024/07/04.
//

import XCTest
@testable import TimeChecker

final class UserDefaultsServiceTests: XCTestCase {
    
    var backUpResults: [TestResult]?
    var service: UserDefaultsService!
    
    override func setUpWithError() throws {
        if let data = UserDefaults.standard.data(forKey: Keys.testResults),
           let results = try? JSONDecoder().decode([TestResult].self, from: data) {
            backUpResults = results
            
            removeSavedResults()
        }
        
        service = UserDefaultsService()
    }
    
    override func tearDownWithError() throws {
        removeSavedResults()
        
        if let backUpResults {
            if let data = try? JSONEncoder().encode(backUpResults) {
                UserDefaults.standard.set(data, forKey: Keys.testResults)
            }
        }
        
        backUpResults = nil
        service = nil
    }
    
    private func removeSavedResults() {
        UserDefaults.standard.removeObject(forKey: Keys.testResults)
    }
    
    
    func testSaveAndFetchResults() {
        let initialResults = service.fetch()
        XCTAssertTrue(initialResults.isEmpty)
        
        let newResults = TestResult.mockArray
        service.save(results: newResults)
        let fetchedNewResults = service.fetch()
        XCTAssertEqual(fetchedNewResults, newResults)
    }
}
