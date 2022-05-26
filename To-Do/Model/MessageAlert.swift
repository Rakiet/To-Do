//
//  MessageAlert.swift
//  To-Do
//
//  Created by Piotr Żakieta on 25/05/2022.
//

import UIKit
import CoreData

class MessageAlert{
    
    
    class func showBasicAlert(title: String, message: String, vc: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    class func showCompletionAlert(title: String, message: String, vc: UIViewController, completionHeander: @escaping  (Bool) -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            completionHeander(true)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func deleteAlert(title: String, message: String, vc: UIViewController, completionHeander: @escaping  (Bool) -> ()){
        let deleteNewAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        deleteNewAlert.addAction(UIAlertAction(title: "Potwierdź", style: .destructive, handler: { (action: UIAlertAction!) in
            completionHeander(true)
        }))

        deleteNewAlert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { (action: UIAlertAction!) in
            completionHeander(false)
            print("nie usunięto")
        }))
        
        

        vc.present(deleteNewAlert, animated: true, completion: nil)
    }
}
