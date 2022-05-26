//
//  CreateNewTaskViewController.swift
//  To-Do
//
//  Created by Piotr Żakieta on 23/05/2022.
//

import UIKit
import CoreData
enum saveDataError: Error{
    case textFileIsEmpty
}
class CreateNewTaskViewController: UIViewController {

    @IBOutlet weak var textTaskTextField: UITextField!
    
    @IBOutlet weak var dataPickerOutlet: UIDatePicker!
    
    @IBOutlet weak var stackViewForDateTextFieldAndTaskTextField: UIStackView!
    
    var typeTaskSelect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textTaskTextField.delegate = self
        dataPickerOutlet.minimumDate = Date()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentCategoryControl(_ sender: UISegmentedControl) {
        typeTaskSelect = sender.selectedSegmentIndex
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.height > size.width{
            stackViewForDateTextFieldAndTaskTextField.axis = .vertical
        }else {
            stackViewForDateTextFieldAndTaskTextField.axis = .horizontal
        }
    }

    @IBAction func saveNewTask(_ sender: Any) {
        do {
            try DatabaseManagement.saveData(textTaskTextField: textTaskTextField, typeTaskSelect: typeTaskSelect)
        } catch saveDataError.textFileIsEmpty{
            MessageAlert.showBasicAlert(title: "Błąd", message: "Pole zadania jest puste", vc: self)
            return
        } catch {
            MessageAlert.showBasicAlert(title: "Błąd", message: "Nieznany błąd, spróbuj zapisać za chwilę", vc: self)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelSaveAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
