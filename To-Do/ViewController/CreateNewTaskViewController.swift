//
//  CreateNewTaskViewController.swift
//  To-Do
//
//  Created by Piotr Żakieta on 23/05/2022.
//

import UIKit
import CoreData

protocol SaveNewTaskProtocol{
    func didSaveNewTask(isSaved: Bool)
}

enum saveDataError: Error{
    case textFileIsEmpty
}

class CreateNewTaskViewController: UIViewController {

    @IBOutlet weak var textTaskTextField: UITextField!
    
    @IBOutlet weak var dataPickerOutlet: UIDatePicker!
    
    @IBOutlet weak var stackViewForDateTextFieldAndTaskTextField: UIStackView!
    
    var typeTaskSelect = 0
    
    var saveNewTaskDelegaye: SaveNewTaskProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textTaskTextField.delegate = self
        dataPickerOutlet.minimumDate = Date()
        // Do any additional setup after loading the view.
        viewChangePosition(size: view.frame.size)
    }
    
    @IBAction func segmentCategoryControl(_ sender: UISegmentedControl) {
        typeTaskSelect = sender.selectedSegmentIndex
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        viewChangePosition(size: size)
    }
    
    @IBAction func saveNewTask(_ sender: Any) {
        do {
            try DatabaseManagement.saveData(textTaskTextField: textTaskTextField, typeTaskSelect: typeTaskSelect, dateDoTask: dataPickerOutlet.date)
        } catch saveDataError.textFileIsEmpty{
            MessageAlert.showBasicAlert(title: "Błąd", message: "Pole zadania jest puste", vc: self)
            return
        } catch {
            MessageAlert.showBasicAlert(title: "Błąd", message: "Nieznany błąd, spróbuj zapisać za chwilę", vc: self)
        }
        
        
        MessageAlert.showCompletionAlert(title: "Sukces", message: "Zapisanie nowego zadania powiodło się.", vc: self, completionHeander: {(success) -> Void in
            if success{
                self.saveNewTaskDelegaye.didSaveNewTask(isSaved: true)
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        
    }
    
    @IBAction func cancelSaveAction(_ sender: Any) {
        self.saveNewTaskDelegaye.didSaveNewTask(isSaved: false)
        navigationController?.popViewController(animated: true)
    }
    
    func viewChangePosition(size: CGSize){
        if size.height > size.width{
            stackViewForDateTextFieldAndTaskTextField.axis = .vertical
        }else {
            stackViewForDateTextFieldAndTaskTextField.axis = .horizontal
        }
    }

}
extension CreateNewTaskViewController: UITextFieldDelegate{
    //ukrywanie ekranu po nacisnieciu przycisku "return" na klawiaturze
        func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
            self.view.endEditing(true)
            return true
        }
        //ukrywanie klawiatury po kliknieciu w dowolne miejsce na ekranie
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}
