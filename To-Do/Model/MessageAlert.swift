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
}
