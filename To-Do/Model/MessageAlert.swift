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
    
    
    
    class func aceptAlert(title: String, message: String, vc: UIViewController, completionHeander: @escaping  (Bool) -> ()){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Potwierdź", style: .destructive, handler: { (action: UIAlertAction!) in
            completionHeander(true)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { (action: UIAlertAction!) in
            completionHeander(false)
            print("nie usunięto")
        }))
        
        

        vc.present(refreshAlert, animated: true, completion: nil)
    }
}
