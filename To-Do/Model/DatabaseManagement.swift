//
//  DatabaseManagement.swift
//  To-Do
//
//  Created by Piotr Żakieta on 25/05/2022.
//

import UIKit
import CoreData

class DatabaseManagement: NSManagedObject {
    
    
    class func saveData(textTaskTextField: UITextField, typeTaskSelect: Int, dateDoTask: Date) throws{
        
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
        create.setValue(dateDoTask, forKey: K.EntityTaskNameValue.dateCreateTask)
        
        do{
            try context.save()
            print("saved")
        } catch{
            throw error
            
        }
    }
    
    class func readBase()throws -> [TasksEntity] {
        var taskFromCoreData:[TasksEntity] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: K.EntityTaskNameValue.nameEntity)
        request.returnsObjectsAsFaults = false
        do {
            taskFromCoreData = try (context.fetch(request) as! [TasksEntity])
        } catch {
            throw error
        }
        return taskFromCoreData
    }
    
    class func deleteData(taskToDelete: TasksEntity) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(taskToDelete as NSManagedObject)
        
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }

        }
}
