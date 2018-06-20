//
//  CalcVC.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 06.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import AVFoundation

class CalcVC: UIViewController {

    
    
    @IBOutlet weak var Display: UILabel!
    
    
    
    
    var btnSound: AVAudioPlayer!
    
    
    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftVal = ""
    var rightVal = ""
    var result = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let path = Bundle.main.path (forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        Display.text = "0"
    }
    
    
    
    
    @IBAction func numberPressed(sender: UIButton){
        //playSound()
        runningNumber += "\(sender.tag)"
        Display.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(operation: .Divide)
        //playSound()
    }
    
    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(operation: .Multiply)
        //playSound()
    }
    
    @IBAction func onSubstractPressed(_ sender: Any) {
        processOperation(operation: .Substract)
        //playSound()
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(operation: .Add)
       // playSound()
    }
    
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(operation: currentOperation)
       // playSound()
        
    }
    
    @IBAction func ClearBtn(_ sender: Any) {
        Display.text = "0"
        currentOperation = Operation.Empty
        runningNumber = ""
        leftVal = ""
        rightVal = ""
        result = ""
        
        
        
    }

    
    
    @IBAction func muteBtn(_ sender: Any) {
        
        
        
        
    }
    
    
    
    
    
    
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
        
        
    }
    
    func processOperation(operation: Operation) {
       // playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightVal = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                    
                    
                }else if currentOperation == Operation.Substract {
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                    
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                    
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                    
                    
                }
                
                
                leftVal = result
                Display.text = result
                
            }
            currentOperation = operation
            
        } else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
        
    }
    


}
