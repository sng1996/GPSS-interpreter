//
//  Interpreter.swift
//  GPSS
//
//  Created by Сергей Гаврилко on 23.04.2018.
//  Copyright © 2018 Сергей Гаврилко. All rights reserved.
//

import UIKit

class Interpreter{
    
    var phase: Phase!
    
    func create_program(){
        var generate = Generate(time: 45, range: 10) //1
        program.append(generate)
        
        var assign = Assign(a: 0, b: constanta + 1) //2
        program.append(assign)
        
        var transfer = Transfer(metka: 7) //3                ---->  RAIL_A
        program.append(transfer)
        
        generate = Generate(time: 45, range: 10) //4
        program.append(generate)
        
        assign = Assign(a: 0, b: constanta + 1) //5
        program.append(assign)
        
        transfer = Transfer(metka: 9) //6                    ---->  RAIL_B
        program.append(transfer)
        
        var seize = Seize(a: 0, b: 1) //7                    /* RAIL_A */
        program.append(seize)
        
        transfer = Transfer(metka: 23) //8                   ----> RAILAC
        program.append(transfer)
        
        seize = Seize(a: 0, b: constanta * 3 + 5) //9        /* RAIL_B */
        program.append(seize)
        
        transfer = Transfer(metka: 38) //10                  ----> RAILBC
        program.append(transfer)
        
        var gate_nu = Gate_nu(a: -3, b: 3 * constanta + 3, metka: nil) //11     /* MET1 */
        program.append(gate_nu)
        
        gate_nu = Gate_nu(a: -3, b: 3 * constanta + 4, metka: 14) //12      ----> MET2
        program.append(gate_nu)
        
        transfer = Transfer(metka: 25) //13                  ----> CON1
        program.append(transfer)
        
        gate_nu = Gate_nu(a: -3, b: 3 * constanta + 4, metka: nil) //14     /* MET2 */
        program.append(gate_nu)
        
        gate_nu = Gate_nu(a: -3, b: 3 * constanta + 3, metka: 11) //15      ----> MET1
        program.append(gate_nu)
        
        transfer = Transfer(metka: 25)  //16                                ----> CON1
        program.append(transfer)
        
        gate_nu = Gate_nu(a: 3, b: 3, metka: nil) //17                      /* MET3 */
        program.append(gate_nu)
        
        gate_nu = Gate_nu(a: 3, b: 2, metka: 20) //18                       ----> MET4
        program.append(gate_nu)
        
        transfer = Transfer(metka: 40) //19                                 ----> CON2
        program.append(transfer)
        
        gate_nu = Gate_nu(a: 3, b: 2, metka: nil) //20                      /* MET4 */
        program.append(gate_nu)
        
        gate_nu = Gate_nu(a: 3, b: 3, metka: 17) //21                       ----> MET3
        program.append(gate_nu)
        
        transfer = Transfer(metka: 40) //22                                 ----> CON2
        program.append(transfer)
        
        assign = Assign(a: 1, b: -1) //23                                   /* RAILAC */
        program.append(assign)
        
        transfer = Transfer(metka: 11) //24                                 ----> MET1
        program.append(transfer)
        
        var release = Release(a: -3, b: 3 * constanta + 1) //25             /* CON1 */
        program.append(release)
        
        seize = Seize(a: -3, b: 3 * constanta + 3) //26
        program.append(seize)
        
        var advance = Advance(time: 15, range: 5) //27
        program.append(advance)
        
        release = Release(a: -3, b: 3 * constanta + 3) //28
        program.append(release)
        
        seize = Seize(a: -3, b: 3 * constanta + 4) //29
        program.append(seize)
        
        var test_le = Test_le(metka: 23, minimum: 1) //30                   ----> RAILAC
        program.append(test_le)
        
        assign = Assign(a: 0, b: 0) //31
        program.append(assign)
        
        gate_nu = Gate_nu(a: 0, b: 3 * constanta + 3, metka: nil) //32
        program.append(gate_nu)
        
        release = Release(a: 0, b: 3 * constanta + 1) //33
        program.append(release)
        
        seize = Seize(a: 0, b: 3 * constanta + 3) //34
        program.append(seize)
        
        advance = Advance(time: 20, range: 5) //35
        program.append(advance)
        
        release = Release(a: 0, b: 3 * constanta + 3) //36
        program.append(release)
        
        var terminate = Terminate() //37
        program.append(terminate)
        
        assign = Assign(a: 1, b: -1) //38                               /* RAILBC */
        program.append(assign)
        
        transfer = Transfer(metka: 17) //39                             ----> MET3
        program.append(transfer)
        
        release = Release(a: 3, b: 5) //40                              /* CON2 */
        program.append(release)
        
        seize = Seize(a: 3, b: 3) //41
        program.append(seize)
        
        advance = Advance(time: 20, range: 5) //42
        program.append(advance)
        
        release = Release(a: 3, b: 3) //43
        program.append(release)
        
        seize = Seize(a: 3, b: 2) //44
        program.append(seize)
        
        test_le = Test_le(metka: 38, minimum: 1) //45                   ----> RAILBC
        program.append(test_le)
        
        assign = Assign(a: 0, b: 0) //46
        program.append(assign)
        
        gate_nu = Gate_nu(a: 0, b: 3, metka: nil) //47
        program.append(gate_nu)
        
        release = Release(a: 0, b: 5) //48
        program.append(release)
        
        seize = Seize(a: 0, b: 3) //49
        program.append(seize)
        
        advance = Advance(time: 15, range: 5) //50
        program.append(advance)
        
        release = Release(a: 0, b: 3) //51
        program.append(release)
        
        terminate = Terminate()
        program.append(terminate) // 52
        
        generate = Generate(time: 1440, range: 0) //53
        program.append(generate)
        
    }
    
    func run(){
        create_program()
        phase_of_enter()
        after_phase_of_enter()
        while phase.time < 1440 {           //TODO: Change it
            correction_timer()
            view_current_events_list()
        }
    }
    
    func phase_of_enter(){
        phase = Phase()
        print_phase()
    }
    
    func after_phase_of_enter(){
        for i in program.indices {
            if program[i].name == .generate {
                let transact = program[i].generate(0)
                transact?.future = i + 1
                phase.future.insert(transact!, at: 0)
            }
        }
        print_phase()
    }
    
    func correction_timer(){
        
        //Find min time
        var min_time = 1440
        for transact in phase.future {
            if transact.time < min_time {
                min_time = transact.time
            }
        }
        
        //Choose transacts and push them to now
        
        let num_of_elements = phase.future.count
        for i in phase.future.indices{              //TODO: Can be bug, check it
            let index = num_of_elements - 1 - i
            if phase.future[index].time == min_time {
                let transact = phase.future.remove(at: index)
                phase.now.insert(transact, at: 0)
            }
        }

        phase.time = min_time
        for transact in phase.now {
            transact.time = phase.time
        }
        print_phase()
        
    }
    
    func view_current_events_list(){
        view_list()
        print_phase()
    }
    
    func view_list(){
        var is_repeat = false
        let num_of_elements = phase.now.count
        for i in phase.now.indices {
            let index = num_of_elements - 1 - i
            var transact: Transact? = phase.now[index]
            while transact != nil {
                let block = program[(transact?.future)!-1]
                print(block.name)
                if (transact?.is_waiting)! {
                    block.current_transact = transact
                    transact = block.exit()
                }
                else {
                    if block.name == .seize || block.name == .release || block.name == .gate_nu {
                        is_repeat = true
                    }
                    block.enter(transact: transact!, phase: phase)
                    transact = block.exit()
                }
                print(transact?.future)
            }
            if is_repeat { view_list(); is_repeat = false; break }
        }
    }
    
    func print_phase(){
        var string = "phase "
        string += "\(phase.time)    "
        for transact in phase.now {
            string += "[\(transact.number), \(transact.time), \(transact.now), \(transact.priority), \(transact.future)]"
        }
        string += " |    "
        for transact in phase.future {
            string += "[\(transact.number), \(transact.time), \(transact.now), \(transact.priority), \(transact.future)]"
        }
        print(string)
    }
}
