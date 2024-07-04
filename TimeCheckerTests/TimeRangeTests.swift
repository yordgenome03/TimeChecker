//
//  TimeCheckerTests.swift
//  TimeCheckerTests
//
//  Created by yotahara on 2024/07/04.
//

import XCTest
@testable import TimeChecker

final class TimeRangeTests: XCTestCase {

    func testContains_sameDay() {
        let range = TimeRange(start: 8, end: 16)
        XCTAssertFalse(range.contains(0))
        XCTAssertFalse(range.contains(1))
        XCTAssertFalse(range.contains(2))
        XCTAssertFalse(range.contains(3))
        XCTAssertFalse(range.contains(4))
        XCTAssertFalse(range.contains(5))
        XCTAssertFalse(range.contains(6))
        XCTAssertFalse(range.contains(7))
        
        XCTAssertTrue(range.contains(8))
        XCTAssertTrue(range.contains(9))
        XCTAssertTrue(range.contains(10))
        XCTAssertTrue(range.contains(11))
        XCTAssertTrue(range.contains(12))
        XCTAssertTrue(range.contains(13))
        XCTAssertTrue(range.contains(14))
        XCTAssertTrue(range.contains(15))
        
        XCTAssertFalse(range.contains(16))
        XCTAssertFalse(range.contains(17))
        XCTAssertFalse(range.contains(18))
        XCTAssertFalse(range.contains(19))
        XCTAssertFalse(range.contains(20))
        XCTAssertFalse(range.contains(21))
        XCTAssertFalse(range.contains(22))
        XCTAssertFalse(range.contains(23))
    }

    func testContains_acrossMidnight() {
        let range = TimeRange(start: 8, end: 2)
        XCTAssertTrue(range.contains(0))
        XCTAssertTrue(range.contains(1))
        
        XCTAssertFalse(range.contains(2))
        XCTAssertFalse(range.contains(3))
        XCTAssertFalse(range.contains(4))
        XCTAssertFalse(range.contains(5))
        XCTAssertFalse(range.contains(6))
        XCTAssertFalse(range.contains(7))
        
        XCTAssertTrue(range.contains(8))
        XCTAssertTrue(range.contains(9))
        XCTAssertTrue(range.contains(10))
        XCTAssertTrue(range.contains(11))
        XCTAssertTrue(range.contains(12))
        XCTAssertTrue(range.contains(13))
        XCTAssertTrue(range.contains(14))
        XCTAssertTrue(range.contains(15))
        XCTAssertTrue(range.contains(16))
        XCTAssertTrue(range.contains(17))
        XCTAssertTrue(range.contains(18))
        XCTAssertTrue(range.contains(19))
        XCTAssertTrue(range.contains(20))
        XCTAssertTrue(range.contains(21))
        XCTAssertTrue(range.contains(22))
        XCTAssertTrue(range.contains(23))
    }

    func testContains_sameTime() {
        let range = TimeRange(start: 8, end: 8)
        XCTAssertFalse(range.contains(0))
        XCTAssertFalse(range.contains(1))
        XCTAssertFalse(range.contains(2))
        XCTAssertFalse(range.contains(3))
        XCTAssertFalse(range.contains(4))
        XCTAssertFalse(range.contains(5))
        XCTAssertFalse(range.contains(6))
        XCTAssertFalse(range.contains(7))
        
        XCTAssertTrue(range.contains(8))
        
        XCTAssertFalse(range.contains(9))
        XCTAssertFalse(range.contains(10))
        XCTAssertFalse(range.contains(11))
        XCTAssertFalse(range.contains(12))
        XCTAssertFalse(range.contains(13))
        XCTAssertFalse(range.contains(14))
        XCTAssertFalse(range.contains(15))
        XCTAssertFalse(range.contains(16))
        XCTAssertFalse(range.contains(17))
        XCTAssertFalse(range.contains(18))
        XCTAssertFalse(range.contains(19))
        XCTAssertFalse(range.contains(20))
        XCTAssertFalse(range.contains(21))
        XCTAssertFalse(range.contains(22))
        XCTAssertFalse(range.contains(23))
    }
}
