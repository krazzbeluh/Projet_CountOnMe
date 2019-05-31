//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

// penser à interdire les operateurs comme première touche

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendAlert),
                                               name: Notification.Name(rawValue: "Alert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView),
                                               name: Notification.Name(rawValue: "TextChanged"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func sendAlert() {
        self.present(calculator.alert, animated: true, completion: nil)
    }
    
    @objc func updateTextView() {
        textView.text = calculator.displayedText
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
