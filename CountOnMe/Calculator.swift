//
//  Calculator.swift
//  CountOnMe
//
//  Created by Paul Leclerc on 29/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

protocol CalculatorDelegate: class {
    func sendAlert(type: Calculator.AlertTypes)
    func updateTextView(with: String)
}

import Foundation

class Calculator {
    weak var delegate: CalculatorDelegate?
    
    public var displayedText = "" {
        didSet {
            delegate?.updateTextView(with: displayedText)
        }
    }
    
    public enum AlertTypes {
        case cantAddOperator, incorrectExpression, rewriteCalc, notEnoughElements
    }
    
    private var elements: [String] {
        return displayedText.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionHaveResult: Bool {
        return displayedText.firstIndex(of: "=") != nil
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != nil
    }
    
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    public func addNumber(_ numberText: String) {
        
        if expressionHaveResult {
            displayedText = ""
        }
        
        displayedText.append(numberText)
    }
    
    public func makeAddition() {
        if canAddOperator {
            displayedText.append(" + ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
    public func makeSubstraction() {
        
        if canAddOperator {
            displayedText.append(" - ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
    public func makeMultiplication() {
        if canAddOperator {
            displayedText.append(" × ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
    public func makeDivision() {
        if canAddOperator {
            displayedText.append(" ÷ ")
        } else {
            sendAlert(type: .cantAddOperator)
        }
    }
    
    public func executeCalculation() {
        guard expressionIsCorrect else {
            sendAlert(type: .incorrectExpression)
            return
        }
        
        guard expressionHaveEnoughElement else {
            sendAlert(type: .notEnoughElements)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 7
            
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            case "=":
                result = Float(elements.last!)!
                sendAlert(type: .rewriteCalc)
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(formatter.string(from: result as NSNumber) ?? "n/a", at: 0)
        }
        
        displayedText.append(" = \(operationsToReduce.first!)")
    }
    
    private func sendAlert(type alertType: AlertTypes) {
        delegate?.sendAlert(type: alertType)
    }
}
