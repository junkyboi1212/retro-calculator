//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mark Price on 8/1/15.
//  Copyright © 2015 devslopes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //Set of operation .....
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""  //is the number pressed by the user or the number shown in the label...
    
    var leftValStr = ""   //is the number which is gained after the running
                         //number is changed into rightvalStr ...
    
    var  rightValStr = "" // is the number which is gained from the running number....
    
    var currentOperation: Operation = Operation.Empty  // is the starting operation...
    
    
    var result = ""   // this indicates the result of the certain operation.....
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
//        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("btn", ofType: "wav")!))
            
            
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        // this pass the integer value in the form of string to running number.....
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        // if currentOperation is not empty than perform this function bcoz sometime user pressed equal btn
        // at that time the program gets crashed.....
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            //  A user selected an operator, but then selected another operator without
            //  first entering a number
            
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                
                
                leftValStr = result  // leftValStr store the result value
                outputLbl.text = result
            }
            
            
            currentOperation = op
            
        } else {
            
            
           //Note:---
            
//             and just with one value the operation doesnot perform
//             so we need two value so first number before pressing the operation btn changed into leftVal and right val is the running number
//              after pressing the operation btn.......
            
            
            
            //This is the first time an operator has been pressed
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
    
    @IBAction func clearPressed(sender : AnyObject) {
       
        
        // we need to clear all the value so that there is no crashed ...
        
        
      runningNumber = ""
        rightValStr = ""
        leftValStr = ""
        currentOperation = Operation.Empty
        result = " "
        outputLbl.text = " "
        
        
    }
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

