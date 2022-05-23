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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTaskCell(idTypeTask: Int, textTask: String){
        
        imageTypeTask.image = assignIconFormIdToImage(idIcon: idTypeTask)
        textTaskLabel.text = textTask
        
    }

    private func assignIconFormIdToImage(idIcon: Int) -> UIImage{
        switch idIcon{
        case 0: return K.jobIconImage!
        case 1: return K.shopIconImage!
        default: return K.otherIconImage!
        }
    }
    
}
