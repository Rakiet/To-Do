//
//  ViewController.swift
//  To-Do
//
//  Created by Piotr Żakieta on 23/05/2022.
//

import UIKit
import CoreData

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var taskFromCoreData: [TaskData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskViewCell.nib(), forCellReuseIdentifier: K.taskViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
        
   
    
}
extension TasksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskFromCoreData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let taskCell = tableView.dequeueReusableCell(withIdentifier: K.taskViewCellIdentifier, for: indexPath) as? TaskViewCell{
            let model = taskFromCoreData[indexPath.row]
            taskCell.configureTaskCell(idTypeTask: model.typeTask, textTask: model.textTask)
            
            cell = taskCell
        }
        
        return cell
    }


}

struct TaskData{
    let typeTask: Int16
    let textTask: String
    let isDone: Bool
    let dateCreateTask: Date
}
