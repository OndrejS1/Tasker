//
//  UserProfiles.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 23.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//





import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct User {
    
    
    var username: String!
    var email: String!
    var photoUrl: String!
    var country: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){
        
        ref = snapshot.ref
        key = snapshot.key
        if let values = snapshot.value as? Dictionary<String,String> {
            username = values["username"]!
            email = values["email"]!
            country = values["country"]!
            photoUrl = values["photoURL"]!
            
        }
        
        
        
    }
    
}














