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
    
    var uncorrectWords = [Words]()
    var countOfUncorrectPairs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        coreData.setDefault()
//        for word in coreData.getAllWords(){
//            uncorrectWords.append(word)
//        }
        
//        for word in 0...coreData.getAllWords().count-1{
//            let tempEngWord = coreData.getAllWords()[word].eng ??  "nil"
//            let tempRusWord = coreData.getAllWords()[word].rus ?? "nil"
////            var tempWords = Words()
////            tempWords.rus = tempRusWord
////            tempWords.eng = tempEngWord
//            uncorrectWords.append(Words())
//            uncorrectWords[word].rus = tempRusWord
//            uncorrectWords[word].eng = tempEngWord
//        }
//
//        for word  in 0...uncorrectWords.count-1{
//            uncorrectWords[word].eng = " "
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coreData.getAllItems()
        tableView.reloadData()
    }
    
    @IBAction func setDefaults(_ sender: Any) {
        coreData.setDefault()
        coreData.getAllItems()
        tableView.reloadData()
    }
    
}

//MARK: - UItableView Delagate & DataSource

extension NewWordsVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         countOfUncorrectPairs = Int.random(in: 0...coreData.getUnKnownWords().count-1)
        print("countOfUncorrectPairs ", countOfUncorrectPairs)
        return coreData.getUnKnownWords().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewWordsCell", for: indexPath) as! NewWordsTableViewCell
//        let countOfUncorrectPairs = Int.random(in: 0 ... coreData.getAllWords().count-1)
//        var countOfKnown = 0
//        for word in 0...coreData.getAllWords().count-1{
//            if coreData.getAllWords()[word].known == true{
//                countOfKnown += 1
//            }
//        }
//
//        if coreData.getAllWords()[indexPath.row].known == false{
//            if indexPath.row <= countOfUncorrectPairs{
//                cell.rusLabel.text = coreData.getAllWords()[Int.random(in: 0...coreData.getAllWords().count-(1+countOfKnown))].rus
//            } else {
//                cell.rusLabel.text = coreData.getAllWords()[indexPath.row].rus
//            }
//            cell.engLabel.text = coreData.getAllWords()[indexPath.row].eng
//        } else {
//            cell.engLabel.text = "Known"
//        }
        if countOfUncorrectPairs > 0{
            cell.rusLabel.text = coreData.getUnKnownWords()[Int.random(in: 0...coreData.getUnKnownWords().count-1)].rus
            cell.engLabel.text = coreData.getUnKnownWords()[Int.random(in: 0...coreData.getUnKnownWords().count-1)].eng
        } else {
            cell.rusLabel.text = coreData.getUnKnownWords()[indexPath.row].rus
            cell.engLabel.text = coreData.getUnKnownWords()[indexPath.row].eng
        }
        
        
        return cell
    }
    
//MARK: Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! NewWordsTableViewCell
        

        if selectedCell.engLabel.text == coreData.getUnKnownWords()[indexPath.row].eng && selectedCell.rusLabel.text == coreData.getUnKnownWords()[indexPath.row].rus{
            
            coreData.getUnKnownWords()[indexPath.row].rightSelection += 1
            coreData.saveChanges()
            
            selectedCell.setCellColor(color: .green) {
                tableView.reloadData()
            }
            
        } else {
            let alertController = UIAlertController(title: "Не верно", message: "Вы выбрали неправильное слово. Повторите попытку.", preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                selectedCell.backgroundColor = .white }))
            self.present(alertController, animated: true, completion: nil)

            coreData.getAllWords()[indexPath.row].rightSelection = 0
        }
        
        if coreData.getUnKnownWords()[indexPath.row].rightSelection == 3{
            coreData.setKnown(engWord: selectedCell.engLabel.text ?? "nil", known: true)
            tableView.reloadData()
        }
    }
    
}
