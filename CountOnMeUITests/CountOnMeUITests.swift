//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Paul Leclerc on 29/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeUITests: XCTestCase {
    var app: XCUIApplication!
    var screenTextView: XCUIElement!
    var screenText: String {
        return screenTextView.value as! String
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will
        // make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        screenTextView = app.textViews["screen"]

        // In UI tests it’s important to set the initial state - such as interface
        // orientation - required for your tests before they run. The setUp method is a
        // good place to do this.
    }
    
    func testGivenTextViewIs1Plus1Equal2_WhenTapping6_ThenTextViewIs6() {
        XCTAssert(screenText == "1+1=2")
        
        app.buttons["6"].tap()
        
        XCTAssert(screenText == "6")
    }
    
    func testGivenTextViewIsDefault_WhenTapping12Times3Equal_ThenTextViewIs12Times3Equals36() {
        
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["×"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        
        XCTAssert(screenText == "12 × 3 = 36")
    }
    
    func testGivenTextViewIsDefault_WhenTapping4Plus5Equal_ThenTextViewIs4Plus5Equals9() {
        
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssert(screenText == "4 + 5 = 9")
    }
    
    func testGivenTextViewIsDefault_WhenTapping80Minus7Equal_ThenTextViewIs6Minus5Equals73() {
        
        app.buttons["8"].tap()
        app.buttons["0"].tap()
        app.buttons["-"].tap()
        app.buttons["7"].tap()
        app.buttons["="].tap()
        
        XCTAssert(screenText == "80 - 7 = 73")
    }
    
    func testGivenTextViewIsDefault_WhenTapping9DividedBy6Equal_ThenTextViewIs9DividedBy6Equals1Dot5() {
        
        app.buttons["9"].tap()
        app.buttons["÷"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        
        XCTAssert(screenText == "9 ÷ 6 = 1.5")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
