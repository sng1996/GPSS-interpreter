//
//  Release.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Release: Block {

    var a: Int!
    var b: Int!
    
    init(a: Int, b: Int){
        super.init()
        self.a = a
        self.b = b
        self.name = .release
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
        
        let device_number = a * current_transact.parameter + b
        for device in devices {
            if device.number == device_number {
                device.is_busy = false
                break
            }
        }
    
        self.current_transact.now = self.current_transact.future
        self.current_transact.future = self.current_transact.now + 1

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
