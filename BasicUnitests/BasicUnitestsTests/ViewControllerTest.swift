//
//  ViewControllerTest.swift
//  BasicUnitestsTests
//
//  Created by Balu Naik on 6/16/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import XCTest
@testable import BasicUnitests

class ViewControllerTest: XCTestCase {
    
    let vc = ViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCheckEven() {
        let odd = 7
        let even = 10
        XCTAssertFalse(vc.checkEvenNumber(odd), "7 Not Even Number ---> false")
        XCTAssertFalse(vc.checkEvenNumber(odd))
        
        XCTAssertTrue(vc.checkEvenNumber(even), "10 Is Even Number ----> true")
        XCTAssertTrue(vc.checkEvenNumber(even))
    }
    
    func testSumOfNaturalNumbers() {
        let input = 5
        let answer = 15
        XCTAssertEqual(vc.sumOfNaturalNumbers(input), answer)
    }

}
