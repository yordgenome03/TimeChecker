//
//  TestResultRepositoryTests.swift
//  TimeCheckerTests
//
//  Created by yotahara on 2024/07/04.
//

import XCTest
@testable import TimeChecker

final class TestResultRepositoryTests: XCTestCase {
    
    var backUpResults: [TestResult]?
    var service: UserDefaultsService!
    var repository: TestResultRepositoryInterface!
    
    override func setUpWithError() throws {
        repository = TestResultRepository()
        service = UserDefaultsService()
        backUpResults = service.fetchResults()
        
        removeSavedResults()
    }
    
    override func tearDownWithError() throws {
        removeSavedResults()
        
        if let backUpResults {
            service.save(results: backUpResults)
        }
        
        backUpResults = nil
        service = nil
        repository = nil
    }
    
    private func removeSavedResults() {
        service.deleteAllResults()
    }
    
    func testSaveAndFetchAndDeleteResults() {
        let initialResults = repository.fetchResults()
        XCTAssertTrue(initialResults.isEmpty)
        
        let firstResult = TestResult(timeRange: .mock_eightToSixteen, target: 5)!
        repository.saveResult(firstResult)
        let fetchedFirstResults = repository.fetchResults()
        XCTAssertEqual(fetchedFirstResults.count, 1)
        XCTAssertEqual(fetchedFirstResults.first, firstResult)
        
        let secondResult = TestResult(timeRange: .mock_zeroToZero, target: 0)!
        repository.saveResult(secondResult)
        let fetchedSecondResults = service.fetchResults()
        XCTAssertEqual(fetchedSecondResults.count, 2)
        XCTAssertEqual(fetchedSecondResults.first, secondResult)
        XCTAssertEqual(fetchedSecondResults[1], firstResult)
        
        let thirdResult = TestResult(timeRange: .mock_sixteenToEight, target: 22)!
        repository.saveResult(thirdResult)
        let fetchedThirdResults = service.fetchResults()
        XCTAssertEqual(fetchedThirdResults.count, 3)
        XCTAssertEqual(fetchedThirdResults.first, thirdResult)
        XCTAssertEqual(fetchedThirdResults[1], secondResult)
        XCTAssertEqual(fetchedThirdResults[2], firstResult)
        
        repository.deleteResults([firstResult, thirdResult])
        let fetchedDeletedResults = service.fetchResults()
        XCTAssertEqual(fetchedDeletedResults.count, 1)
        XCTAssertEqual(fetchedDeletedResults.first, secondResult)
    }
    
    func testDeleteAllResults() {
        let initialResults = repository.fetchResults()
        XCTAssertTrue(initialResults.isEmpty)
        
        let firstResult = TestResult(timeRange: .mock_eightToSixteen, target: 5)!
        repository.saveResult(firstResult)
        let secondResult = TestResult(timeRange: .mock_zeroToZero, target: 0)!
        repository.saveResult(secondResult)
        let fetchedNewResults = repository.fetchResults()
        XCTAssertEqual(fetchedNewResults, [secondResult, firstResult])
        
        repository.deleteAllResults()
        let fetchedDeletedResults = repository.fetchResults()
        XCTAssertTrue(fetchedDeletedResults.isEmpty)
    }}
