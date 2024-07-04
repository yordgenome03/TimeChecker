//
//  TimeCheckerTests.swift
//  TimeCheckerTests
//
//  Created by yotahara on 2024/07/04.
//

import XCTest
@testable import TimeChecker

final class TimeRangeTests: XCTestCase {

    func testInitialize_invalidValue() {
        XCTAssertNil(TimeRange(start: -1, end: 8))
        XCTAssertNil(TimeRange(start: 8, end: -1))
        XCTAssertNil(TimeRange(start: 8, end: 24))
        XCTAssertNil(TimeRange(start: 24, end: 8))
    }
    
    func testContains_invalidValue() {
        guard let range = TimeRange(start: 8, end: 16) else {
            return XCTFail()
        }
        
        XCTAssertThrowsError(try range.contains(-1)) { error in
            XCTAssertEqual(error as? TimeRangeError, TimeRangeError.invalid)
        }
        XCTAssertThrowsError(try range.contains(24)) { error in
            XCTAssertEqual(error as? TimeRangeError, TimeRangeError.invalid)
        }
    }

    func testContains_sameDay() {
        guard let range = TimeRange(start: 8, end: 16) else {
            return XCTFail()
        }
        XCTAssertFalse(try range.contains(0))
        XCTAssertFalse(try range.contains(1))
        XCTAssertFalse(try range.contains(2))
        XCTAssertFalse(try range.contains(3))
        XCTAssertFalse(try range.contains(4))
        XCTAssertFalse(try range.contains(5))
        XCTAssertFalse(try range.contains(6))
        XCTAssertFalse(try range.contains(7))
        
        XCTAssertTrue(try range.contains(8))
        XCTAssertTrue(try range.contains(9))
        XCTAssertTrue(try range.contains(10))
        XCTAssertTrue(try range.contains(11))
        XCTAssertTrue(try range.contains(12))
        XCTAssertTrue(try range.contains(13))
        XCTAssertTrue(try range.contains(14))
        XCTAssertTrue(try range.contains(15))
        
        XCTAssertFalse(try range.contains(16))
        XCTAssertFalse(try range.contains(17))
        XCTAssertFalse(try range.contains(18))
        XCTAssertFalse(try range.contains(19))
        XCTAssertFalse(try range.contains(20))
        XCTAssertFalse(try range.contains(21))
        XCTAssertFalse(try range.contains(22))
        XCTAssertFalse(try range.contains(23))
    }

    func testContains_acrossMidnight() {
        guard let range = TimeRange(start: 8, end: 2) else {
            return XCTFail()
        }
        XCTAssertTrue(try range.contains(0))
        XCTAssertTrue(try range.contains(1))
        
        XCTAssertFalse(try range.contains(2))
        XCTAssertFalse(try range.contains(3))
        XCTAssertFalse(try range.contains(4))
        XCTAssertFalse(try range.contains(5))
        XCTAssertFalse(try range.contains(6))
        XCTAssertFalse(try range.contains(7))
        
        XCTAssertTrue(try range.contains(8))
        XCTAssertTrue(try range.contains(9))
        XCTAssertTrue(try range.contains(10))
        XCTAssertTrue(try range.contains(11))
        XCTAssertTrue(try range.contains(12))
        XCTAssertTrue(try range.contains(13))
        XCTAssertTrue(try range.contains(14))
        XCTAssertTrue(try range.contains(15))
        XCTAssertTrue(try range.contains(16))
        XCTAssertTrue(try range.contains(17))
        XCTAssertTrue(try range.contains(18))
        XCTAssertTrue(try range.contains(19))
        XCTAssertTrue(try range.contains(20))
        XCTAssertTrue(try range.contains(21))
        XCTAssertTrue(try range.contains(22))
        XCTAssertTrue(try range.contains(23))
    }

    func testContains_sameTime() {
        guard let range = TimeRange(start: 8, end: 8) else {
            return XCTFail()
        }
        XCTAssertFalse(try range.contains(0))
        XCTAssertFalse(try range.contains(1))
        XCTAssertFalse(try range.contains(2))
        XCTAssertFalse(try range.contains(3))
        XCTAssertFalse(try range.contains(4))
        XCTAssertFalse(try range.contains(5))
        XCTAssertFalse(try range.contains(6))
        XCTAssertFalse(try range.contains(7))
        
        XCTAssertTrue(try range.contains(8))
        
        XCTAssertFalse(try range.contains(9))
        XCTAssertFalse(try range.contains(10))
        XCTAssertFalse(try range.contains(11))
        XCTAssertFalse(try range.contains(12))
        XCTAssertFalse(try range.contains(13))
        XCTAssertFalse(try range.contains(14))
        XCTAssertFalse(try range.contains(15))
        XCTAssertFalse(try range.contains(16))
        XCTAssertFalse(try range.contains(17))
        XCTAssertFalse(try range.contains(18))
        XCTAssertFalse(try range.contains(19))
        XCTAssertFalse(try range.contains(20))
        XCTAssertFalse(try range.contains(21))
        XCTAssertFalse(try range.contains(22))
        XCTAssertFalse(try range.contains(23))
    }
}
