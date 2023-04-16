//
//  DemoAPIProjectApp.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 14/04/23.
//

import SwiftUI

@main
struct DemoAPIProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
