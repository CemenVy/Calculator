//
//  ViewController.swift
//  Calculator
//
//  Created by Семен Выдрин on 24.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var calcButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in calcButtons {
            button.layer.cornerRadius = button.frame.size.height / 2;
            
        }
        
    }


}

