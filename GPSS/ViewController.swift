//
//  ViewController.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 22.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interpreter = Interpreter()
        interpreter.run()
    }
    
}


