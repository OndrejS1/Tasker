//
//  Task.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 14.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase





class Task {
    
    
    var taskName: String!
    var taskImage: String!
    var username: String!
    var taskDate = String()
    var key: String!
    var ref: FIRDatabaseReference?
    var days: String!
    
    
    init(taskName: String, taskDate: String, taskImage: String, username: String, key: String = "", days: String = "3") {
        
        self.username = username
        self.taskName = taskName
        self.taskImage = taskImage
        self.taskDate = taskDate
        self.days = days
        self.key = key
        self.ref = FIRDatabase.database().reference()
        
    }
    
    init (snapshot: FIRDataSnapshot) {
 
            self.key = snapshot.key
            self.ref = snapshot.ref
            
            if let values = snapshot.value as? Dictionary<String,String> {
            
                    self.taskName = values["taskName"]! as String
                    self.taskImage = values["taskImage"]! as String
                    self.taskDate = values["taskDate"]! as String
                    self.username = values["username"]! as String
                    self.days = values["days"]! as String
                
        }
        
    }
    
    func toAnyObject() -> [String: AnyObject] {
        
        return ["taskName": taskName as AnyObject, "taskImage": taskImage as AnyObject, "taskDate": taskDate as AnyObject, "username": username as AnyObject, "days": days as AnyObject]
        
        
    }
    
    func ToDate(taskDate: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "cs-CZ") as Locale!
        let startDate = dateFormatter.date(from: taskDate)
        return startDate!
        
        
    }
    
    
    
    
     func daysBetween(end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: ToDate(taskDate: nowDate), to: end).day!
    }
    
    
    var nowDate: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = NSLocale(localeIdentifier: "cs-CZ") as Locale!
        let datum = dateFormatter.string(from: NSDate() as Date)
        return datum
        
    }
    

}
