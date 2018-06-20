//
//  LoginVC.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 14.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    
    
    
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var passwordUser: UITextField!
    let networkingService = NetworkingService()
    let alertMsg = AlertMsg()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    
    @IBAction func unwindToLogIn(storyboard: UIStoryboardSegue){
        
    
    }
    
    @IBAction func logInAction(_ sender: Any) {
        
        if let email = emailUser.text, let pass = passwordUser.text {
            
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: {
                (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "GoHome", sender: self)
                    self.alertMsg.successAlert()
                    
                }
                else {
                    
                    self.alertMsg.failAlert()
                    self.performSegue(withIdentifier: "GoRegister", sender: self)
                }
                
                
                
            })
            
        }
        
        
        
        
        
        
    }
    
    

}

