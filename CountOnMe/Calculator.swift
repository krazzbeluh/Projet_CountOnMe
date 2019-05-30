//
//  Calculator.swift
//  CountOnMe
//
//  Created by Paul Leclerc on 29/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class Calculator {
    public var alert = UIAlertController()
    
    var displayedText = "" {
        didSet {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "TextChanged")))
        }
    }
    
    private var elements: [String] {
        return displayedText.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionHaveResult: Bool {
        return displayedText.firstIndex(of: "=") != nil
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    func sendAlert(title: String, message: String, buttonName: String) {
        alert = UIAlertController(title: title,
                                        message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonName, style: .cancel, handler: nil))
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "Alert")))
    }
    
    func addNumber(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            displayedText = ""
        }
        
        displayedText.append(numberText)
    }
    
    func makeAddition() {
        if canAddOperator {
            displayedText.append(" + ")
        } else {
            sendAlert(title: "Zéro!", message: "Un opérateur est déjà mis !", buttonName: "OK")
        }
    }
    
    func makeSubstraction() {
        
        if canAddOperator {
            displayedText.append(" - ")
        } else {
            sendAlert(title: "Zéro!", message: "Un operateur est déja mis !", buttonName: "OK")
        }
    }
    
    func executeCalculation() {
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
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "=":
                result = Int(elements[0])!
                sendAlert(title: "Zéro!", message: "Veuillez réécrire un calcul", buttonName: "OK")
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        displayedText.append(" = \(operationsToReduce.first!)")
    }
}
