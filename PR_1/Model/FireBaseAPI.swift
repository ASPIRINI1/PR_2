//
//  FireBaseAPI.swift
//  PR_2
//
//  Created by Станислав Зверьков on 12.02.2022.
//

import Foundation
import Firebase

class FireBaseAPI{
    static let shared = FireBaseAPI()
    private var docs = [FireDoc]()
    
    private func configureFB() -> Firestore{
       var db: Firestore!
       let settings = FirestoreSettings()
       Firestore.firestore().settings = settings
       db = Firestore.firestore()
       return db
   }
    
    func getData(collection: String, docName: String, completion: @escaping(FireDoc?) -> Void){
       let db = configureFB()
       db.collection(collection).document(docName).getDocument(completion:{ (document, error) in
           guard error == nil else {completion(nil);return}
           let doc = FireDoc(eng: document?.get("eng") as! String, rus: document?.get("rus") as! String, known: document?.get("known") as! Bool, rightSelection: document?.get("rightSelection") as! Int, id: document!.documentID)
           completion(doc)
       })
   }
   
   func getDocuments(completion: @escaping([FireDoc]?) -> Void){
       let db = configureFB()
       db.collection("Words").getDocuments()  { (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               self.docs.removeAll()
               for document in querySnapshot!.documents {
                   self.docs.append(FireDoc(eng: document.get("eng") as! String, rus: document.get("rus") as! String, known: document.get("known") as! Bool, rightSelection: document.get("rightSelection") as! Int, id: document.documentID))
               }
               completion(self.docs)
           }
       }
   }
   
//     func createNewDocument(head:String, body:String, completion: () -> Void){
//        let db = configureFB()
//        if head != ""{
//            db.collection("Notes").addDocument(data: [
//                "NoteHead": head,
//                "NoteBody": body])
//        } else {print("head = empty")}
//    }
   
    func createNewDocument(eng: String, rus: String){
      let db = configureFB()
          db.collection("Words").addDocument(data: [
              "eng": eng,
              "rus": rus,
              "known" : false,
              "rightSelection" : 0])
       getDocuments { _ in }
  }
   
    func updateDocument(id: String, known: Bool){
      let db = configureFB()
          db.collection("Words").document(id).updateData([
           "known" : known
          ]) { err in
           if let err = err {
               print("Error updating document: \(err)")
           } else {
               print("Document successfully updated")
           }
        }
    }
    
    
    func deleteDocument(id: String){
        let db = configureFB()
        db.collection("Words").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
