//
//  LogLevelTest.swift
//  PAUDPLogger
//
//  Created by MuronakaHiroaki on 2015/06/19.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import UIKit
import XCTest

class LogLevelTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPrint() {
        // This is an example of a functional test case.
        XCTAssertEqual(LogLevel.None.description, "None")
        XCTAssertEqual(LogLevel.Debug.description, "Debug")
        XCTAssertEqual(LogLevel.Warning.description, "Warn")
        XCTAssertEqual(LogLevel.Fatal.description, "Fatal")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
