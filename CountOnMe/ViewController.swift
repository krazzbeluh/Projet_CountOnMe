//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

protocol CalculatorDelegate: class {
    func sendAlert(title: String, message: String)
    func updateTextView(with: String)
}

import UIKit

class ViewController: UIViewController, CalculatorDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateTextView(with text: String) {
        textView.text = text
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calculator.addNumber(numberText)
    }
    
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

}
