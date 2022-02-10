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
            
            saveChanges()
        } else {
            print("Empty String")
        }
    }
    
    func deleteItem(itemIndex: Int){
        context.delete(model[itemIndex])
        do{
            try context.save()
        } catch {
            print("Deleting error")
        }
        getAllItems()
    }
    
    
    func getAllWords() -> [Words]{
        return model
    }
    
    func getKnownWords() -> [Words]{
        var words = [Words]()
        for word in model{
            if word.known == true{
                words.append(word)
            }
        }
        return words
    }
    
    func getUnKnownWords() -> [Words]{
        var words = [Words]()
        for word in model{
            if word.known == false{
                words.append(word)
            }
        }
        return words
    }
    
    func setKnown(engWord: String, known: Bool){
        for word in model{
            if word.eng == engWord{
                word.known = known
            }
        }
        saveChanges()
        getAllItems()
    }
    
    func setDefault(){
        for model in model {
            model.known = false
            model.rightSelection = 0
        }
       saveChanges()
    }
    
    func saveChanges(){
        do{
            try context.save()
        } catch {
            print("Saving error")
        }
    }
  
}

