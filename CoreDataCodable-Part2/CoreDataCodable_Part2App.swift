//
//  CoreDataCodable_Part2App.swift
//  CoreDataCodable-Part2
//
//  Created by Danjuma Nasiru on 24/02/2023.
//

import SwiftUI

@main
struct CoreDataCodable_Part2App: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
