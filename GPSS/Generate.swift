//
//  Generate.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Generate: Block{
    
    var time: Int!
    var range: Int!
    
    init(time: Int, range: Int){
        super.init()
        self.time = time
        self.range = range
        self.name = .generate
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
        
        self.current_transact.now = self.current_transact.future
        self.current_transact.future = self.current_transact.now + 1
        
        if range != 0 {
            let new_transact = generate(current_phase.time)
            new_transact?.future = current_transact.now
            current_phase.future.insert(new_transact!, at: 0)
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
    
    override func generate(_ current_time: Int) -> Transact?{
        generated_elements += 1
        
        let transact = Transact()
        if range == 0 {
            transact.time = time
        }
        else {
            let tmp = 2*range + 1
            transact.time = current_time + Int(arc4random_uniform(UInt32(tmp))) - range + time
        }
        transact.number = generated_elements
        transact.priority = 0
        return transact
    }
    
}
