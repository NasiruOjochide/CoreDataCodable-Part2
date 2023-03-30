//
//  DataController.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import CoreData
import Foundation

class DataController : ObservableObject{
    var container = NSPersistentContainer(name: "deyPlay")
    
    init(){
        container.loadPersistentStores(completionHandler: {(description, error) in
            if let _ = error {
                print("error loading data")
            }
        })
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}

