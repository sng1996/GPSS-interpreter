//
//  Terminate.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 24.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Terminate: Block {
    
    override init(){
        super.init()
        self.name = .terminate
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
    }
    
    override func exit() -> Transact?{
        let index = current_phase.now.index{$0.number == current_transact.number}
        current_phase.now.remove(at: index!)
        return nil
    }
    
}
