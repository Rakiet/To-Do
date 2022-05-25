//
//  DatabaseManagement.swift
//  To-Do
//
//  Created by Piotr Żakieta on 25/05/2022.
//

import UIKit
import CoreData

class DatabaseManagement: NSManagedObject {
    
    
    class func saveData(textTaskTextField: UITextField, typeTaskSelect: Int) throws{
        
        let textTask = textTaskTextField.text!
        if textTask.isEmpty {
            throw saveDataError.textFileIsEmpty
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: K.EntityTaskNameValue.nameEntity, in: context)
        let create = NSManagedObject(entity: entity!, insertInto: context)
        create.setValue(textTask, forKey: K.EntityTaskNameValue.textTask)
        create.setValue(Int16(typeTaskSelect), forKey: K.EntityTaskNameValue.typeTask)
        create.setValue(false, forKey: K.EntityTaskNameValue.isDone)
        create.setValue(Date(), forKey: K.EntityTaskNameValue.dateCreateTask)
        
        do{
            try context.save()
            print("saved")
        } catch{
            throw error
            
        }
    }
    
    class func readBase()throws -> [TaskModel] {
        var taskFromCoreData:[TaskModel] = []
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
                taskFromCoreData.append(TaskModel(typeTask: typeTask, textTask: textTask, isDone: isDone, dateCreateTask: time))
                
                
            }
        } catch {
            throw error
        }
        return taskFromCoreData
    }
}
