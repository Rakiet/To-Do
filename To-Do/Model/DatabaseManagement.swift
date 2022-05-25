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
        let createe = NSManagedObject(entity: entity!, insertInto: context)
        createe.setValue(textTask, forKey: K.EntityTaskNameValue.textTask)
        createe.setValue(Int16(typeTaskSelect), forKey: K.EntityTaskNameValue.typeTask)
        createe.setValue(false, forKey: K.EntityTaskNameValue.isDone)
        createe.setValue(Date(), forKey: K.EntityTaskNameValue.dateCreateTask)
        
        do{
            try context.save()
            print("saved")
        } catch{
            throw error
            
        }
    }
}
