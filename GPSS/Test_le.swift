//
//  Test_le.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Test_le: Block {

    var metka: Int!
    var minimum: Int!
    
    init(metka: Int, minimum: Int){
        super.init()
        self.metka = metka
        self.minimum = minimum
        self.name = .test_le
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
        
        self.current_transact.now = self.current_transact.future
        
        if current_transact.parameter > minimum {
            self.current_transact.future = metka
        }
        else {
            self.current_transact.future = self.current_transact.now + 1
        }
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
