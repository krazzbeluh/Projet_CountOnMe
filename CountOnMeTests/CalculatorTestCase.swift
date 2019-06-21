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
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
    }

    func testGivenDisplayedTextIsVoid_WhenAddingNumbers_ThenDisplayedTextIncludesNumbers() {
        for int in 0...9 {
            calculator.addNumber(String(int))
        }

        XCTAssert(calculator.displayedText == "0123456789")
    }

    func testGivenDisplayedTextIs5_WhenMakingAddition_ThenDisplayedTextIncludes5Plus() {
        calculator.addNumber("5")
        
        calculator.makeAddition()
        
        XCTAssert(calculator.displayedText == "5 + ")
    }
    
    func testGivenDisplayedTextIs5_WhenMakingSubstraction_ThenDisplayedTextIncludes5Minus() {
        calculator.addNumber("5")
        
        calculator.makeSubstraction()
        
        XCTAssert(calculator.displayedText == "5 - ")
    }
    
    func testGivenDisplayedTextIs5_WhenMakingMultiplication_ThenDisplayedTextIs5Times() {
        calculator.addNumber("5")
        
        calculator.makeMultiplication()
        
        XCTAssert(calculator.displayedText == "5 × ")
    }
    
    func testGivenDisplayedTextIs5_WhenMakingDivision_ThenDisplayedTextIs5Times() {
        calculator.addNumber("5")
        
        calculator.makeDivision()
        
        XCTAssert(calculator.displayedText == "5 ÷ ")
    }
    
    func testGivenDisplayedTextIs5Plus4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        let operation = "5 + 4", expectedResult = "9"
        calculator.displayedText = operation
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "\(operation) = \(expectedResult)")
    }
    
    func testGivenDisplayedTextIs5Minus4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        let operation = "5 - 4", expectedResult = "1"
        calculator.displayedText = operation
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "\(operation) = \(expectedResult)")
    }
    
    func testGivenDisplayedTextIs5Times4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        let operation = "5 × 4", expectedResult = "20"
        calculator.displayedText = operation
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "\(operation) = \(expectedResult)")
    }
    
    func testGivenDisplayedTextIs9DividedBy8_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        let operation = "9 ÷ 8", expectedResult = "1.125"
        calculator.displayedText = operation
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "\(operation) = \(expectedResult)")
    }
    
    func testGivenOperationFinished_WhenAddingNumber_ThenDisplayedTextIsTheNumber() {
        calculator.displayedText = "1 + 1 = 2"
        
        calculator.addNumber("2")
        
        XCTAssert(calculator.displayedText == "2")
    }

    func testGivenOperationIs1Plus_WhenMakingAddition_ThenDisplayedTextIsNotChanged() {
        calculator.displayedText = "1 + "
        
        calculator.makeAddition()
        
        XCTAssert(calculator.displayedText == "1 + ")
    }
    
    func testGivenOperationIs1Plus_WhenMakingSubstraction_ThenDisplayedTextIsNotChanged() {
        calculator.displayedText = "1 + "
        
        calculator.makeSubstraction()
        
        XCTAssert(calculator.displayedText == "1 + ")
    }
    
    func testGivenOperationIs1Plus_WhenMakingMultiplication_ThenDisplayedTextIsNotChanged() {
        calculator.displayedText = "1 + "
        
        calculator.makeMultiplication()
        
        XCTAssert(calculator.displayedText == "1 + ")
    }
    
    func testGivenOperationIs1Plus_WhenMakingDivision_ThenDisplayedTextIsNotChanged() {
        calculator.displayedText = "1 + "
        
        calculator.makeDivision()
        
        XCTAssert(calculator.displayedText == "1 + ")
    }
    
    func testGivenOperationIs1Plus_WhenMakingOperation_ThenDisplayedTextIsNotChanged() {
        calculator.displayedText = "1 + "
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "1 + ")
    }
    
    func testGivenOperationIs1_WhenExecutingCalculation_ThenDisplayedTextIsNotChanged() {
        calculator.displayedText = "1"
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "1")
    }
    
    func testGivenOperationHasAlreadyAResult_WhenExecutingCalculation_ThenDisplayedTextIsResultEqualsResult() {
        calculator.displayedText = "1 + 1 = 2"
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "1 + 1 = 2 = 2")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
