//
//  CoreDataManager.swift
//  PR_1
//
//  Created by Станислав Зверьков on 31.01.2022.
//

import Foundation
import CoreData

class CoreDataManager{
    private let modelName: String
    
    init(modelName:String){
        self.modelName = modelName
    }
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "mmomd") else { return nil }
        let managerObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        return managerObjectModel
    }()
    
    private var presistentStoreURL: NSURL {
        let storeName = "\(modelName).sqlite"
        
        let filemanager = FileManager.default
        let documentDirectoryURL = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectoryURL.appendingPathComponent(storeName) as NSURL
    }
    
    private lazy var presistentStoreCoordinator:NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = self.managedObjectModel else { return nil }
        let presistentStoreURL = self.presistentStoreURL
        let presistentStoreCoorditator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try presistentStoreCoorditator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: presistentStoreURL as URL, options: options)
        } catch {
            let error = error as NSError
            print("\(error.localizedDescription)")
        }
        return presistentStoreCoorditator
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        return managedObjectContext
    }()
    
    private(set)lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext.parent = self.privateManagedObjectContext
        return managedContext
    }()
}
