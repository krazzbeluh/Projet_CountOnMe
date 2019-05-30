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
//    trouver une methode plus adaptée au MVC
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
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
        calculator.addNumber(sender)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.makeAddition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.makeSubstraction()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.executeCalculation()
    }

}
