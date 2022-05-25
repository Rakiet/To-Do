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
    
    
    var taskFromCoreData: [TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TaskViewCell.nib(), forCellReuseIdentifier: K.taskViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        
      
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readBase()
        tableView.reloadData()
    }
        
   
    func readBase(){
        taskFromCoreData = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: K.EntityTaskNameValue.nameEntity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let typeTask = data.value(forKey: K.EntityTaskNameValue.typeTask) as! Int16
                let textTask = data.value(forKey: K.EntityTaskNameValue.textTask) as! String
                let isDone = data.value(forKey: K.EntityTaskNameValue.isDone) as! Bool
                let time = data.value(forKey: K.EntityTaskNameValue.dateCreateTask) as! Date
                self.taskFromCoreData.append(TaskModel(typeTask: typeTask, textTask: textTask, isDone: isDone, dateCreateTask: time))
                
                
            }
        } catch {
            print("Failed")
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let viewController = segue.destination as? CreateNewTaskViewController {
//            viewController.managedObjectContext = persistentContainer.viewContext
//            print("FDfdfd")
//        }
//    }
    
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


