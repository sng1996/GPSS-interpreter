//
//  Block.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

enum Names{
    case generate, assign, transfer, seize, release, gate_nu, test_le, advance, terminate
}

class Block{
    
    var name: Names!
    var counter: Int = 0
    var current_transact: Transact!
    var current_phase: Phase!
    
    func enter(transact: Transact, phase: Phase) {}
    
    func exit() -> Transact? { return nil }
    
    func generate(_ current_time: Int) -> Transact? { return nil }
    
    func can_serve(transact: Transact) -> Bool { return true }
    
}
