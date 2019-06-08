//
//  Calculator.swift
//  CountOnMe
//
//  Created by Paul Leclerc on 29/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    weak var delegate: CalculatorDelegate?
    
    public var displayedText = "" {
        didSet {
            delegate?.updateTextView(with: displayedText)
        }
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
    
    private func sendAlertOperator() {
        sendAlert(title: "Zéro!", message: "Impossible d'ajouter un opérateur !", buttonName: "OK")
    }
    
    public func makeAddition() {
        if canAddOperator {
            displayedText.append(" + ")
        } else {
            sendAlertOperator()
        }
    }
    
    public func makeSubstraction() {
        
        if canAddOperator {
            displayedText.append(" - ")
        } else {
            sendAlertOperator()
        }
    }
    
    public func makeMultiplication() {
        if canAddOperator {
            displayedText.append(" × ")
        } else {
            sendAlertOperator()
        }
    }
    
    public func makeDivision() {
        if canAddOperator {
            displayedText.append(" ÷ ")
        } else {
            sendAlertOperator()
        }
    }
    
    public func executeCalculation() {
        guard expressionIsCorrect else {
            sendAlert(title: "Zéro!", message: "Entrez une expression correcte !", buttonName: "OK")
            return
        }
        
        guard expressionHaveEnoughElement else {
            sendAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !", buttonName: "OK")
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
                sendAlert(title: "Zéro!", message: "Veuillez réécrire un calcul", buttonName: "OK")
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(formatter.string(from: result as NSNumber) ?? "n/a", at: 0)
        }
        
        displayedText.append(" = \(operationsToReduce.first!)")
    }
    
    private func sendAlert(title: String, message: String, buttonName: String) {
        delegate?.sendAlert(title: title, message: message)
    }
}
