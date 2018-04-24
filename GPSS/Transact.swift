//
//  Transact.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Transact{
    
    var number: Int = 0
    var time: Int = 0
    var now: Int = 0
    var priority: Int = 0
    var future: Int = 0
    var parameter: Int = 0
    var is_waiting: Bool = false
    
    func copy() -> Transact{
        let new_transact = Transact()
        new_transact.number = self.number
        new_transact.time = self.time
        new_transact.now = self.now
        new_transact.priority = self.priority
        new_transact.future = self.future
        new_transact.parameter = self.parameter
        return new_transact
    }
    
}
