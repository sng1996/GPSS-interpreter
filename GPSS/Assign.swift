//
//  Assign.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Assign: Block{
    
    var a: Int!
    var b: Int!
    
    init(a: Int, b: Int){
        super.init()
        self.a = a
        self.b = b
        self.name = .assign
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
        
        self.current_transact.now = self.current_transact.future
        self.current_transact.future = self.current_transact.now + 1
        
        current_transact.parameter = a * current_transact.parameter + b
    }
    
    override func exit() -> Transact?{
        let next_block = program[self.current_transact.future - 1]
        if !next_block.can_serve(transact: current_transact) {
            current_transact.is_waiting = true
            return nil
        }
        
        current_transact.is_waiting = false
        return current_transact
    }
}
