//
//  CoreDataManager.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
  
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var model = [Words]()
    
    init() {
        getAllItems()
    }
    
    func getAllItems(){
        do{
            model = try context.fetch(Words.fetchRequest())
            print(model.count, "Count")
        } catch {
            print("Getting error")
        }
    }
    
    func addItem(engText: String, rusText:String){
        if engText != "" && rusText != ""{
            let newItem = Words(context: context)
            newItem.eng = engText
            newItem.rus = rusText
            
            do{
                try context.save()
            } catch {
                print("Saving error")
            }
        } else {
            print("Empty String")
        }
    }
    
    func deleteItem(item: Int){
        context.delete(model[item])
        model.remove(at: item)
        do{
            try context.save()
        } catch {
            print("Deleting error")
        }
    }
    
    func getAllWords() -> [Words]{
        return model
    }
  
}

