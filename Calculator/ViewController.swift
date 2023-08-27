//
//  ViewController.swift
//  Calculator
//
//  Created by Семен Выдрин on 24.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet private var displayResultLabel: UILabel!
    @IBOutlet private var buttonsOnCalculator: [UIButton]!
    
    // MARK: - Private Properties
    private var stillTyping = false
    private var dotIsPlaced = false
    private var firstOperand = 0.0
    private var secondOperand = 0.0
    private var operationSign = ""
    
    private var currentInput: Double {
        get {
            return Double(displayResultLabel.text ?? "") ?? 0
        }
        
        set {
            let value = "\(newValue)"
            let values = value.components(separatedBy: ".")
            
            if values [1] == "0" {
                displayResultLabel.text = "\(values[0])"
            } else {
                displayResultLabel.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }
    
    // MARK: - View Life Cycles
    override func viewWillLayoutSubviews() {
        for button in buttonsOnCalculator {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
    }
    
    // MARK: - IB Action
    @IBAction private func numbersOnCalculatorButtonsPressed(_ sender: UIButton) {
        let number = sender.currentTitle
        
        if stillTyping {
            if displayResultLabel.text!.count < 10 {
                displayResultLabel.text = displayResultLabel.text! + (number ?? "")
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction private func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction private func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "/":
            operateWithToOperands {$0 / $1}
        case "x":
            operateWithToOperands {$0 * $1}
        case "+":
            operateWithToOperands {$0 + $1}
        case "-":
            operateWithToOperands {$0 - $1}
        default: break
        }
    }
    
    @IBAction private func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
    }
    
    @IBAction private func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction private func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction private func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
        }
    }
    
    // MARK: - Private Methods
    private func operateWithToOperands(_ closure: (Double, Double) -> Double) {
        currentInput = closure(firstOperand, secondOperand)
    }
    
}


