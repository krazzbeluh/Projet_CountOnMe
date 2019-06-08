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
    enum Operations {
        case addition, substraction, multiplication, division
    }
    
    func addNumber(_ num: Int) {
        calculator.addNumber(String(num))
    }
    
    func writeOperation(_ operation: String) {
        calculator.displayedText = operation
    }
    
    func makeATestFor(operation: String, expectedResult: String) {
        writeOperation(operation)
        
        calculator.executeCalculation()
        
        XCTAssert(calculator.displayedText == "\(operation) = \(expectedResult)")
    }
    
    func verifyAdding(operation: Operations) {
        addNumber(5)
        var result = "5 "
        
        switch operation {
        case .addition:
            calculator.makeAddition()
            result.append("+ ")
        case .substraction:
            calculator.makeSubstraction()
            result.append("- ")
        case .multiplication:
            calculator.makeMultiplication()
            result.append("× ")
        case .division:
            calculator.makeDivision()
            result.append("÷ ")
        }
    }
    
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
        verifyAdding(operation: .addition)
    }
    
    func testGivenDisplayedTextIs5_WhenMakingSubstraction_ThenDisplayedTextIncludes5Minus() {
        verifyAdding(operation: .substraction)
    }
    
    func testGivenDisplayedTextIs5_WhenMakingMultiplication_ThenDisplayedTextIs5Times() {
        verifyAdding(operation: .multiplication)
    }
    
    func testGivenDisplayedTextIs5_WhenMakingDivision_ThenDisplayedTextIs5Times() {
        verifyAdding(operation: .division)
    }
    
    func testGivenDisplayedTextIs5Plus4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        makeATestFor(operation: "5 + 4", expectedResult: "9")
    }
    
    func testGivenDisplayedTextIs5Minus4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        makeATestFor(operation: "5 - 4", expectedResult: "1")
    }
    
    func testGivenDisplayedTextIs5Times4_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        makeATestFor(operation: "5 × 4", expectedResult: "20")
    }
    
    func testGivenDisplayedTextIs9DividedBy8_WhenExecutingOperation_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        makeATestFor(operation: "9 ÷ 8", expectedResult: "1.125")
    }
    
    func testGivenDisplayedTextIsVoid_WhenWritingOperationAndExecutingIt_ThenDisplayedTextIncludesCalculationDetailAndResult() {
        for int in 1 ... 4 {
            switch int {
            case 1: makeATestFor(operation: "9 + 8", expectedResult: "17")
            case 2: makeATestFor(operation: "9 - 8", expectedResult: "1")
            case 3: makeATestFor(operation: "9 × 8", expectedResult: "72")
            case 4: makeATestFor(operation: "9 ÷ 8", expectedResult: "1.125")
            default: fatalError("Unexisting Int !")
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
