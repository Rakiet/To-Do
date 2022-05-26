//
//  TaskViewCell.swift
//  To-Do
//
//  Created by Piotr Żakieta on 23/05/2022.
//

import UIKit

class TaskViewCell: UITableViewCell {
    @IBOutlet weak var imageTypeTask: UIImageView!
    @IBOutlet weak var textTaskLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTaskCell(idTypeTask: Int16, textTask: String, dateTask: Date?){
        
        imageTypeTask.image = assignIconFormIdToImage(idIcon: idTypeTask)
        textTaskLabel.text = textTask
        if let dateTask = dateTask {
            dateTextLabel.text = setStringFromDate(date: dateTask)
            self.setDateTextField(dateTask: dateTask)
        } else {
            dateTextLabel.text = ""
        }
    }
    
    func setDateTextField(dateTask: Date){
        if Calendar.current.isDate(dateTask, inSameDayAs: Date.now){
            dateTextLabel.textColor = UIColor.systemBlue
        } else if dateTask < Date.now{
            dateTextLabel.textColor = UIColor.red
        } else if dateTask > Date.now{
            dateTextLabel.textColor = UIColor.systemGreen
        }
    }

    private func assignIconFormIdToImage(idIcon: Int16) -> UIImage{
        switch idIcon{
        case 0: return K.jobIconImage!
        case 1: return K.shopIconImage!
        default: return K.otherIconImage!
        }
    }
    
    static func nib() -> UINib{
        return UINib(nibName: K.taskViewCellNibName, bundle: nil)
    }
    
    func setStringFromDate(date: Date) -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.string(from: date)
        }
    
}
