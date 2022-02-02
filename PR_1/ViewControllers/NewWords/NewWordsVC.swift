//
//  GuessingViewController.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit

class NewWordsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    let coreData = CoreDataManager()
    var countOfRightSelections = 0
    var unCurrectWordsPairs = [Words]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    


}

//MARK: - UItableView Delagate & DataSource

extension NewWordsVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.getUnKnownWordsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordsCell", for: indexPath) as! NewWordsTableViewCell
        
        if coreData.getAllWords()[indexPath.row].known == false{
        cell.rusLabel.text = coreData.getAllWords()[indexPath.row].rus
        cell.engLabel.text = coreData.getAllWords()[indexPath.row].eng
        
        }
        return cell
    }
    
//MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
            if coreData.getAllWords()[indexPath.row].known == true{
                print("known")
                selectedCell?.backgroundColor = .green
                countOfRightSelections += 1
                if countOfRightSelections == 3{
                    
                }
            } else {
                print("unknown")
                selectedCell?.backgroundColor = .red
                let alertController = UIAlertController(title: "Не верно", message: "Вы выбрали неправильное слово. Повторите попытку.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                countOfRightSelections = 0
            }
    }
    
}
