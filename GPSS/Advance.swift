//
//  Advance.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Advance: Block {

    var time: Int!
    var range: Int!
    
    var current_time: Int = 0
    
    init(time: Int, range: Int){
        super.init()
        self.time = time
        self.range = range
        self.name = .advance
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
        
        generate_current_time()
        
        //TODO: Удалить из цепочки текущих событий
        let index = current_phase.now.index{$0.number == current_transact.number}
        current_phase.now.remove(at: index!)
        
        //TODO: Добавить в цепочку будущих событий
        current_phase.future.insert(current_transact, at: 0)
        
        //TODO: Установить время
        current_transact.time += current_time
        
        self.current_transact.now = self.current_transact.future
        self.current_transact.future = self.current_transact.now + 1
    }
    
    override func exit() -> Transact?{
        self.current_transact.is_waiting = false
        return nil
    }
    
    func generate_current_time(){
        let tmp = 2*range + 1
        current_time = Int(arc4random_uniform(UInt32(tmp))) - range + time
    }
    
}
