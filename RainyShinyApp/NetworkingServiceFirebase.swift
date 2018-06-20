//
//  NetworkingServiceFirebase.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 20.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase



class NetworkingService {
    var alertMsg = AlertMsg()
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
        
    }
    var storageRef: FIRStorageReference {
        
        return FIRStorage.storage().reference()
    }
    
    
    
    
    private func saveUser(user: FIRUser!, username: String, password: String, country: String) {
        
        //User dictionary info
        let userInfo = ["email": user.email!, "username": username, "country": country, "uid": user.uid, "photoURL": String(describing: user.photoURL!)]
        
        //create user Reference
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        // Save user info into DB
        
        userRef.setValue(userInfo)
        
        
        // Signing in user
        
        signIn(email: user.email!, password: password)
        
    }
    
    func signIn(email: String, password: String){
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user, error) in
        if error == nil {
            
            self.alertMsg.successAlert()

        }
        
        else {
            
            self.alertMsg.failureAlert(error: error as! NSError)
            
        }
        
    })
    
}

    private func setUserInfo(user: FIRUser!, username: String, password: String, country: String, data: NSData!) {
        // Create Path for User image
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        // Create image reference
        
        let imageRef = storageRef.child(imagePath)
        // Metadata for image
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        // Save UI into Storage file
        
        imageRef.put(data as Data, metadata: metaData, completion: { (metaData, error) in
            if error == nil {
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData?.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        self.saveUser(user: user, username: username, password: password, country: country)
                        
                    }else {
                        print(error!)
                    }
                
                
                })
                
            }else {
                
                print(error!)
            }
        })

    
    }
    
 // Firebase sign up process
    func signUp(email: String, username: String, password: String, country: String, data: NSData!){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user: user, username: username, password: password, country: country, data: data)
                
               
                let alert = UIAlertView(title: "Success!",
                                        message: "Account has been created",
                                        delegate: nil,
                                        cancelButtonTitle: "OK")
                
                alert.show()
                
            } else {
                
                self.alertMsg.failureAlert(error: error as! NSError)
                
            }
            
    
        })
        
        
    }
    
    func resetPW(email: String) {
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                
                let alert = UIAlertView(title: "Success!",
                                        message: "We sent you email to reset your password.",
                                        delegate: nil,
                                        cancelButtonTitle: "OK")
                
                alert.show()
                
                
            } else {
                
                self.alertMsg.failureAlert(error: error as! NSError)
            
            }
            
        })
    }
    

}

    
    
    
    
    

