//
//  AddWordVC.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import UIKit
import CoreData

class AddWordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    func saveWord(rus:String, eng:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Words", in: context) else { return }
        
    }


}
