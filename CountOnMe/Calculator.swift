//
//  Calculator.swift
//  CountOnMe
//
//  Created by Paul Leclerc on 29/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

// Delegate protocol
protocol CalculatorDelegate: class {
    func sendAlert(type: Calculator.AlertTypes)
    func updateTextView(with: String)
}

import Foundation

class Calculator {
    weak var delegate: CalculatorDelegate?
    
//    the text who will be displayed on the calculator Screen. It automatically updates the screen
    public var displayedText = "" {
        didSet {
            delegate?.updateTextView(with: displayedText)
        }
    }
    
//    the different types of alerts in the calculator
    public enum AlertTypes {
        case cantAddOperator, incorrectExpression, rewriteCalc, notEnoughElements
    }
    
//    separates the calculation elements
    private var elements: [String] {
        return displayedText.split(separator: " ").map { "\($0)" }
    }
    
//    checks if the expression has a result
    private var expressionHaveResult: Bool {
        return displayedText.firstIndex(of: "=") != nil
    }
    
//    chscks if an operator can be added
    private var canAddOperator: Bool {
        return expressionIsCorrect && elements.last != nil
    }
    
//    checks if expression is correct and can be calculated
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    
//    checks if expression has enough elements to be calculated
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
//    adds a number to displayedText and erases old calc if it's already calculated
    public func addNumber(_ numberText: String) {
        
        if expressionHaveResult {
            displayedText = ""
        }
        
        displayedText.append(numberText)
    }
    
//    adds addition operator
    public func makeAddition() {
        if canAddOperator {
            displayedText.append(" + ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
//    adds substraction operator
    public func makeSubstraction() {
        
        if canAddOperator {
            displayedText.append(" - ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
//    adds multiplication operator
    public func makeMultiplication() {
        if canAddOperator {
            displayedText.append(" × ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
//    adds division operator
    public func makeDivision() {
        if canAddOperator {
            displayedText.append(" ÷ ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
    public func clearText() {
        displayedText = ""
    }
    
    public func executeCalculation() {
        guard expressionIsCorrect else { // if expression is incorrect, sends an alert
            sendAlert(type: .incorrectExpression)
            return
        }
        
        guard expressionHaveEnoughElement else { // if expression hasn't enough elements, sends an alert
            sendAlert(type: .notEnoughElements)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var index = 0
            var thereIsAPriorityOperator = false
            
            for element in operationsToReduce {
                if element == "×" || element == "÷" {
                    thereIsAPriorityOperator = true
                }
            }
            
            if thereIsAPriorityOperator {
                for element in operationsToReduce {
                    if element == "×" || element == "÷" {
                        operationsToReduce = calculate(in: operationsToReduce, operandIndex: index)
                        index -= 2
                    }
                    index += 1
                }
            } else {
                
                if operationsToReduce[1] == "=" {
                    sendAlert(type: .rewriteCalc)
                } else {
                    operationsToReduce = calculate(in: operationsToReduce, operandIndex: 1)
                }
            }
            
            thereIsAPriorityOperator = false
        }
        let result = Float(operationsToReduce.last!)!
        displayedText.append(" = \(formatFloat(result))")
    }
    
    private func calculate(in elements: [String], operandIndex: Int) -> [String] {
        var elements = elements
        let left = Float(elements[operandIndex - 1])!
        let right = Float(elements[operandIndex + 1])!
        let result: Float
        
        switch elements[operandIndex] {
        case "×": result = left * right
        case "÷": result = left / right
        case "+": result = left + right
        case "-": result = left - right
        default: fatalError("Unknown operator !")
        }
        
        elements.remove(at: operandIndex + 1)
        elements.remove(at: operandIndex)
        elements.remove(at: operandIndex - 1)
        elements.insert(String(result), at: operandIndex - 1)
        
        return elements
    }
    
    private func formatFloat(_ number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 7
        
        return formatter.string(from: number as NSNumber) ?? "n/a"
    }
    
    private func sendAlert(type alertType: AlertTypes) {
        delegate?.sendAlert(type: alertType)
    }
}
