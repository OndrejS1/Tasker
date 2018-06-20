//
//  LandingVC.swift
//  RainyShinyApp
//
//  Created by Ondřej Svojše on 27.02.17.
//  Copyright © 2017 Ondřej Svojše. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase






class LandingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var task: Task!
    var tasklist = [Task]()
    var databaseRef: FIRDatabaseReference!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        if FIRAuth.auth()?.currentUser == nil {
            
        } else {
            databaseRef = FIRDatabase.database().reference().child("Todos")
            databaseRef.observe(.value, with: { (snapshot) in
                
                var newItems = [Task]()
                for item in snapshot.children {
                    let newTask = Task(snapshot: item as! FIRDataSnapshot)
                    newItems.insert(newTask, at: 0)
                    
                }
                self.tasklist = newItems
                self.myTableView.reloadData()
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
        
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? taskCell {
            
            let task = tasklist[indexPath.row]
            cell.configureTask(task: task)
            return cell
    
        }
        return taskCell()
    }
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{

            let ref = tasklist[indexPath.row].ref
            ref!.removeValue()
            tasklist.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

}
