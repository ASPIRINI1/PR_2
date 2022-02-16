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
    var countOfUncorrectPairs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.coreData.getAllItems()
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coreData.getAllItems()
        tableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: Any) {
        tableView.reloadData()
    }
    
}

//MARK: - UItableView Delagate & DataSource

extension NewWordsVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coreData.getUnKnownWords().count > 0 {
            countOfUncorrectPairs = Int.random(in: 0...coreData.getUnKnownWords().count-1)
        }
        return coreData.getUnKnownWords().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordsCell", for: indexPath) as! NewWordsTableViewCell
        
        if countOfUncorrectPairs > 1{
            if  Int.random(in: 0...2) == 0 {
                cell.rusLabel.text = coreData.getUnKnownWords()[indexPath.row].rus
                cell.engLabel.text = coreData.getUnKnownWords()[indexPath.row].eng
            } else {
                cell.rusLabel.text = coreData.getUnKnownWords()[Int.random(in: 0...coreData.getUnKnownWords().count-1)].rus
                cell.engLabel.text = coreData.getUnKnownWords()[Int.random(in: 0...coreData.getUnKnownWords().count-1)].eng
            }
        }
        return cell
    }
    
//MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! NewWordsTableViewCell
        var currectWord = Words()
        
        for word in coreData.getUnKnownWords(){
            if selectedCell.engLabel.text == word.eng{
                currectWord = word
            }
        }
        
        if selectedCell.rusLabel.text == currectWord.rus {
            currectWord.rightSelection += 1
            coreData.saveChanges()
            
            selectedCell.setCellColor(color: .green) {
                tableView.reloadData()
            }
            
            if currectWord.rightSelection == 3 {
                coreData.setKnown(engWord: selectedCell.engLabel.text ?? "nil", known: true)
                tableView.reloadData()
            }
            
        } else {
            selectedCell.setCellColor(color: .red) {   }
            currectWord.rightSelection = 0
            
            let alertController = UIAlertController(title: "Не верно", message: "Вы выбрали неправильное слово. Повторите попытку.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                selectedCell.backgroundColor = .white }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
