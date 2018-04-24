//
//  Gate_nu.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Gate_nu: Block {

    var a: Int!
    var b: Int!
    var metka: Int?
    
    init(a: Int, b: Int!, metka: Int?){
        super.init()
        self.a = a
        self.b = b
        self.metka = metka ?? nil
        self.name = .gate_nu
    }
    
    override func enter(transact: Transact, phase: Phase){
        self.current_transact = transact
        self.current_phase = phase
        counter += 1
        
        var current_device: Device!
        
        let device_number = a * current_transact.parameter + b
        var is_found = false
        for device in devices {
            if device.number == device_number {
                current_device = device
                is_found = true
            }
        }
        if !is_found {
            let device = Device(number: device_number)
            current_device = device
            devices.append(device)
        }
        
        self.current_transact.now = self.current_transact.future
        if metka == nil {
            self.current_transact.future = self.current_transact.now + 1
        }
        else {
            if current_device.is_busy {
                self.current_transact.future = metka!
            }
            else {
                self.current_transact.future = self.current_transact.now + 1
            }
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
    
    override func can_serve(transact: Transact) -> Bool{
        let device_number = a * transact.parameter + b
        for device in devices {
            if device.number == device_number {
                if device.is_busy { return false }
                else { return true }
            }
        }
        let device = Device(number: device_number)
        devices.append(device)
        return true
    }
    
}
