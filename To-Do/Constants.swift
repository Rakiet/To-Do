//
//  Constants.swift
//  To-Do
//
//  Created by Piotr Żakieta on 23/05/2022.
//

import UIKit

struct K{
    static let taskViewCellNibName = "TaskViewCell"
    static let taskViewCellIdentifier = "TaskCell"
    
    static let jobIconImage = UIImage(named: "job-icon")
    static let shopIconImage = UIImage(named: "shop-icon")
    static let otherIconImage = UIImage(named: "other-icon")
    
    struct EntityTaskNameValue{
        static let nameEntity = "TasksEntitie"
        static let typeTask = "typeTask"
        static let textTask = "textTask"
        static let isDone = "isDone"
        static let dateCreateTask = "dateCreateTask"
    }
}
