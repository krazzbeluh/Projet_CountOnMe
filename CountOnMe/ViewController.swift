//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculatorDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator.delegate = self
    }
    
//    sends an alert to user
    func sendAlert(type: Calculator.AlertTypes) {
        let message: String
        switch type {
        case .cantAddOperator:
            message = "Impossible d'ajouter un opérateur !"
        case .incorrectExpression:
            message = "Entrez une expression correcte !"
        case .rewriteCalc:
            message = "Veuillez réécrire un calcul"
        case .notEnoughElements:
            message = "Démarrez un nouveau calcul !"
        }
        
        let alert = UIAlertController(title: "Zéro !", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//    updates textView
    func updateTextView(with text: String) {
        textView.text = text
    }
    
//     sends a number to add
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calculator.addNumber(numberText)
    }
    
//    calls calculation methods
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.makeAddition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.makeSubstraction()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.makeMultiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.makeDivision()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.executeCalculation()
    }
    
    @IBAction func tappedClearButton(_ sender: UIButton) {
        calculator.clearText()
    }
    
}
