//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Paul Leclerc on 30/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    var calculator: Calculator!
    
    func addNumber(_ num: Int) {
        calculator.addNumber(String(num))
    }
    
    func writeOperation(_ operation: String) {
        calculator.displayedText = operation
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
    }

    func testGivenDisplayedTextIsVoid_WhenAddingNumber_ThenDisplayedTextIncludesNumber() {
        for int in 0...9 {
            addNumber(int)
        }

        XCTAssert(calculator.displayedText == "0123456789")
    }
    
//    func testGivenDisplayedTextIsVoid_WhenMakingAddition_ThenDisplayedTextStaysVoid() {
//        calculator.makeAddition()
//
//        XCTAssert(calculator.displayedText == "")
//    }

    func testGivenDisplayedTextIs5_WhenMakingAddition_ThenDisplayedTextIncludes5Plus() {
        addNumber(5)
        
        calculator.makeAddition()

        XCTAssert(calculator.displayedText == "5 + ")
    }
    
    func testGivenDisplayedTextIs5_WhenMakingSubstraction_ThenDisplayedTextIncludes5Minus() {
        addNumber(5)
        
        calculator.makeSubstraction()
        
        XCTAssert(calculator.displayedText == "5 - ")
    }
    
    func testGivenDisplayedTextIs5_WhenMakingMultiplication_ThenDisplayedTextIs5Times() {
        addNumber(5)
        
        calculator.makeMultiplication()
        
        XCTAssert(calculator.displayedText == "5 × ")
    }
    
    func testGivenDisplayedTextIs5_WhenMakingDivision_ThenDisplayedTextIs5Times() {
        addNumber(5)
        
        calculator.makeDivision()
        
        XCTAssert(calculator.displayedText == "5 ÷ ")
    }
    
    func testGivenDisplayedTextIs5Plus4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        writeOperation("5 + 4")
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "5 + 4 = 9")
    }
    
    func testGivenDisplayedTextIs5Minus4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        writeOperation("5 - 4")
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "5 - 4 = 1")
    }
    
    func testGivenDisplayedTextIs5Times4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        writeOperation("5 × 4")
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "5 × 4 = 20")
    }
    
    func testGivenDisplayedTextIs5DividedBy4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        writeOperation("20 ÷ 4")
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "20 ÷ 4 = 5")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
