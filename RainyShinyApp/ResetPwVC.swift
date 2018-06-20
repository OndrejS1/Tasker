//
//  ResetPwVC.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 14.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit

class ResetPwVC: UIViewController {

    
    
    let alertMsg = AlertMsg()
    let networkingService = NetworkingService()
    @IBOutlet weak var emailLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func ResetPw(_ sender: Any) {
        
        if (emailLabel.text!.isEmail) {
            networkingService.resetPW(email: "\(emailLabel.text!)")
            
        } else {
            
            emailLabel.text! = ""
            let alert = UIAlertView(title: "Oops!",
                                    message: "Wrong email format has been entered.",
                                    delegate: nil,
                                    cancelButtonTitle: "OK")
            
            alert.show()
        }
     
    }
    
    
}
