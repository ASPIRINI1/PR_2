//
//  AddWordVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit
import CoreData

class AddWordVC: UIViewController {

    @IBOutlet weak var engTextField: UITextField!
    @IBOutlet weak var rusTextField: UITextField!
    
    let coreData = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        
        guard let engText = engTextField.text else { return }
        guard let rusText = rusTextField.text else { return }
        let rusCharacters = "йцукенгшщзхъфывапролджэёячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮ"
        let engCharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
        engTextField.text = engText.filter { engCharacters.contains($0) }
        rusTextField.text = rusText.filter { rusCharacters.contains($0) }
        
        if (rusTextField.text != nil && engTextField.text != nil) && (rusTextField.text != "" && engTextField.text != ""){
            
            coreData.addItem(engText: engTextField.text!, rusText: rusTextField.text!)
            
            let successAletr = UIAlertController(title: "Добавление успешно", message: "Слово добавлено в архив слов.", preferredStyle: .alert)
            successAletr.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(successAletr, animated: true, completion: nil)
            engTextField.text = ""
            rusTextField.text = ""
            
        } else {
            let failAletr = UIAlertController(title: "Слово не добавлено", message: "Слово не может быть добавлено в архив слов. Проверьте правильность ввода.", preferredStyle: .alert)
            failAletr.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(failAletr, animated: true, completion: nil)
        }
    }
    
    
    
}
