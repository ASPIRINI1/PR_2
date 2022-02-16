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
        } catch {
            print("Getting error")
        }
    }
    
    func addItem(engText: String, rusText:String, known: Bool, rightSelection: Int64, id: String){
        if engText != "" && rusText != ""{
            let newItem = Words(context: context)
            newItem.eng = engText
            newItem.rus = rusText
            newItem.known = known
            newItem.rightSelection = rightSelection
            newItem.id = id
            saveChanges()
        } else {
            print("Empty String")
        }
        getAllItems()
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
    
    func deleteAll(){
        for mod in model {
            context.delete(mod)
        }
        print("model ", model)
        saveChanges()
    }
    
    func saveFromFireBase(docs: [FireDoc]){
        for doc in docs{
            addItem(engText: doc.eng, rusText: doc.rus, known: doc.known, rightSelection: Int64(doc.rightSelection), id: doc.id)
        }
    }
  
}

