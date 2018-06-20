//
//  taskCell.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 14.03.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit



class taskCell: UITableViewCell {
    
    @IBOutlet weak var TaskName: UILabel!
    @IBOutlet weak var TaskDate: UILabel!
    @IBOutlet weak var TaskImportance: UIImageView!
    @IBOutlet weak var username: UILabel!
    

    func configureTask(task: Task) {
        
            username.text = task.username
            TaskName.text = task.taskName
        if (task.daysBetween(end: task.ToDate(taskDate: task.taskDate)) < Int(task.days)! && task.daysBetween(end: task.ToDate(taskDate: task.taskDate)) >= 0) {
            TaskDate.textColor = UIColor.red
        } else if ( task.daysBetween(end: task.ToDate(taskDate: task.taskDate)) < 0) {
            TaskDate.textColor = UIColor.orange
        } else {
            TaskDate.textColor = UIColor.white
        
        }
        TaskDate.text = task.taskDate
        TaskImportance.image = UIImage(named: task.taskImage)
 
    }
    
    
    
    
    
    
    
    
    
    
    

}
