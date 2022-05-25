//
//  CreateNewTaskViewController.swift
//  To-Do
//
//  Created by Piotr Żakieta on 23/05/2022.
//

import UIKit
import CoreData

class CreateNewTaskViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentCategoryControl(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    

    func saveData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: K.EntityTaskNameValue.nameEntity, in: context)
        let createe = NSManagedObject(entity: entity!, insertInto: context)
        createe.setValue("Tutaj tekst zadania", forKey: K.EntityTaskNameValue.textTask)
        createe.setValue(Int16(1), forKey: K.EntityTaskNameValue.typeTask)
        createe.setValue(false, forKey: K.EntityTaskNameValue.isDone)
        createe.setValue(Date(), forKey: K.EntityTaskNameValue.dateCreateTask)
        
        do{
            try context.save()
            print("saved")
        } catch{
            print("Failed saving")
        }
        
    }
    
    @IBAction func saveNewTask(_ sender: Any) {
        saveData()
        navigationController?.popToRootViewController(animated: true)
    }
    


}
