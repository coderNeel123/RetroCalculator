//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Neel Khattri on 7/19/16.
//  Copyright © 2016 SimpleStuff. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    
    
    enum Operation: String {
        case divide = "/"
        case mulitply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "Empty"
    }
    
    
    
    
    var buttonSound = AVAudioPlayer!()
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.empty
    var total = ""
    
    
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    
    }
    
    
    @IBAction func decimalPressed(sender: AnyObject) {
        playSound()
        decimalPressed()
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        playSound()
        clear()
    }
    

    @IBAction func numberPressed (button: UIButton!) {
       playSound()
        
        runningNumber += "\(button.tag)"
        outputLabel.text = runningNumber
    }
    
    
    @IBAction func multiplyPressed(sender: AnyObject) {
        processOperation(Operation.mulitply)
    }
    
    
    @IBAction func dividePressed(sender: AnyObject) {
        processOperation(Operation.divide)
    }
    
    
    @IBAction func subtractPressed(sender: AnyObject) {
        processOperation(Operation.subtract)
    }
    
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperation(Operation.add)
    }
    
    
    @IBAction func equalPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    func processOperation(operation: Operation) {
        playSound()
        
        
        if currentOperation != Operation.empty {
            
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.mulitply {
                total = "\(Double(leftValString)! * Double(rightValString)!)"
                }
                else if currentOperation == Operation.divide {
                total = "\(Double(leftValString)! / Double(rightValString)!)"
                }
                else if currentOperation == Operation.subtract {
                total = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                else if currentOperation == Operation.add {
                total = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                leftValString = total
                outputLabel.text = total
            }
            
            currentOperation = operation
            
            
        } else {
            if runningNumber == "" {
            // Do nothing
            }
            else {
                leftValString = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
            
            
        }
        
    }
    
    func clear () {
        leftValString = ""
        rightValString = ""
        runningNumber = ""
        currentOperation = Operation.empty
        outputLabel.text = "0"
    }
    
    func decimalPressed () {
        if runningNumber == "" {
            runningNumber += "."
            outputLabel.text = runningNumber

        }
        else {
        if runningNumber != "."{
            let decimalCharacter: Set<Character> = ["."]

            if decimalCharacter.isSubsetOf(runningNumber.characters) != true {
                runningNumber += "."
                outputLabel.text = runningNumber
            }
            else {
                // Do nothing
            }
      }
       
    }
    }
    
    func playSound () {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
}

