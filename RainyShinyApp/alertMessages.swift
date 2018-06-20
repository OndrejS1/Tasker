//
//  alertMessages.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 23.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth

class AlertMsg {
    
    

    
    func successAlert() {
        
        let alert = UIAlertView(title: "Success!",
                                message: "Go ahead and have fun",
                                delegate: nil,
                                cancelButtonTitle: "OK")
       
        alert.show()
    }
    
    func failureAlert(error: NSError) {
        
        let alert = UIAlertView(title: "Oops!",
                                message: "\(error.localizedDescription)",
            delegate: nil,
            cancelButtonTitle: "OK")
        
        alert.show()
        
    }
    
    
    
    func createdAlert() {
        
        let alert = UIAlertView(title: "Welcome!",
                                message: "Account has been created",
                                delegate: nil,
                                cancelButtonTitle: "OK")
        
        alert.show()
    }
    
    
    func savedAlert() {
        
        let alert = UIAlertView(title: "Done!",
                                message: "Changes have been saved",
                                delegate: nil,
                                cancelButtonTitle: "OK")
        
        alert.show()
        
    }
    
    func failAlert() {
        
        let alert = UIAlertView(title: "Oops!",
                                message: "Login has failed, try again.",
            delegate: nil,
            cancelButtonTitle: "OK")
        
        alert.show()
        
    }
    
    
    
}












