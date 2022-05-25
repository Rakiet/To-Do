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
    
    
    var taskFromCoreData = [TasksEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TaskViewCell.nib(), forCellReuseIdentifier: K.taskViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
             taskFromCoreData = try DatabaseManagement.readBase()
        } catch {
            
        }
        tableView.reloadData()
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
            taskCell.configureTaskCell(idTypeTask: model.typeTask, textTask: model.textTask ?? "BRAK")
            
            cell = taskCell
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MessageAlert.aceptAlert(title: "Uwaga", message: "Twoje dane przepadną i nie będzie można ich odzyskać", vc: self, completionHeander: {(success) -> Void in
                
                if success{
                    DatabaseManagement.deleteData(taskToDelete: self.taskFromCoreData[indexPath.row])
                    self.taskFromCoreData.remove(at: indexPath.row)
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.tableView.endUpdates()
                }
            })
            
            
            
            
        }
    }
    
    
}


