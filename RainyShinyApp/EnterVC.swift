//
//  EnterVC.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 14.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class EnterVC: UIViewController {
    
    let dataPicker = UIDatePicker()
    
    var databaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    
    @IBOutlet weak var DatePickerText: UITextView!
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var ImportantSwitch: UISwitch!
    @IBAction func Actionbutton(_ sender: UIButton) {
        
       if input.text != "" {
        
            let todoRef = databaseRef.child("Todos").childByAutoId()
        
            let task = Task(taskName: input.text!, taskDate: DatePickerText.text!, taskImage: getImager(ImportantSwitch: ImportantSwitch), username: FIRAuth.auth()!.currentUser!.displayName!)
            todoRef.setValue(task.toAnyObject())
        
            input.text = ""
            ImportantSwitch.setOn(false, animated: true)
        
       } else {
            print("Nothing added")
    
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker()
        
    }
    
    
   
    
    
    let datePicker = UIDatePicker()
   
    func DatePicker() {
        
        datePicker.locale = NSLocale(localeIdentifier: "cs-CZ") as Locale!
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        DatePickerText.inputAccessoryView = toolbar
        DatePickerText.inputView = datePicker
        
        print(datePicker.date)
        
        
    }
    
    
    
    func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = NSLocale(localeIdentifier: "cs-CZ") as Locale!
        
        DatePickerText.text! = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
        
    }
    
    
    
    func getImager(ImportantSwitch: UISwitch) -> String {
       
        if ImportantSwitch.isOn {
            return "important.png"
            
        }else {
            return "rsz_chill.png"
        }
        
    }
    func DateAsString(date: NSDate) -> String {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let str = dateFormatter.string(from: date as Date)
        return str
    }
    
    
 
    

}
