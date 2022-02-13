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
           let doc = FireDoc(eng: document?.get("eng") as! String, rus: document?.get("rus") as! String, known: document?.get("known") as! Bool, rightSelection: document?.get("rightSelection") as! Int )
           completion(doc)
       })
   }
   
   func getDocuments(completion: @escaping([FireDoc]?) -> Void){
       let db = configureFB()
       db.collection("Words").getDocuments()  { (querySnapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in querySnapshot!.documents {
                   self.docs.append(FireDoc(eng: document.get("eng") as! String, rus: document.get("rus") as! String, known: document.get("known") as! Bool, rightSelection: document.get("rightSelection") as! Int))
                   completion(self.docs)
               }
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
   
   func createNewDocument(){
      let db = configureFB()
          db.collection("Words").addDocument(data: [
              "eng": "new eng",
              "rus": "new rus",
              "known" : false,
              "rightSelection" : 0])
       getDocuments { doc in
           
       }
  }
   
    func updateDocument(documentInd: Int, eng:String, rus:String, known: Bool, rightSelection: Int){
      let db = configureFB()
      if eng != "" && rus != ""{
          db.collection("Words").document("Words").updateData([
           "eng": eng,
           "rus": rus,
           "known" : known,
           "rightSelection" : rightSelection
           
       ]) { err in
           if let err = err {
               print("Error updating document: \(err)")
           } else {
               print("Document successfully updated")
           }
//       } else {print("head = empty")}
  }
      }}
}
