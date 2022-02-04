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
        let countOfUncorrectPairs = Int.random(in: 0 ... coreData.getAllWords().count-1)
        var countOfKnown = 0
        for word in 0...coreData.getAllWords().count-1{
            if coreData.getAllWords()[word].known == true{
                countOfKnown += 1
            }
        }
        
        if coreData.getAllWords()[indexPath.row].known == false{
            if indexPath.row <= countOfUncorrectPairs{
                cell.rusLabel.text = coreData.getAllWords()[Int.random(in: 0...coreData.getAllWords().count-(1+countOfKnown))].rus
            } else {
                cell.rusLabel.text = coreData.getAllWords()[indexPath.row].rus
            }
            cell.engLabel.text = coreData.getAllWords()[indexPath.row].eng
        } else {
            
        }
        return cell
    }
    
//MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! NewWordsTableViewCell
        
        if coreData.getAllWords()[indexPath.row].eng == selectedCell.engLabel.text && coreData.getAllWords()[indexPath.row].rus == selectedCell.rusLabel.text{
            
            coreData.getAllWords()[indexPath.row].rightSelection += 1
            selectedCell.setCellColor(color: "green") {
            tableView.reloadData()
            }
            
            if coreData.getAllWords()[indexPath.row].rightSelection == 3{
                coreData.getAllWords()[indexPath.row].known = true
                tableView.reloadData()
            }
            } else {
                selectedCell.backgroundColor = .red
                  
                let alertController = UIAlertController(title: "Не верно", message: "Вы выбрали неправильное слово. Повторите попытку.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    selectedCell.backgroundColor = .white }))
                
                self.present(alertController, animated: true, completion: nil)
                coreData.getAllWords()[indexPath.row].rightSelection = 0
            }
    }
    
}
