//
//  ContentView.swift
//  DemoAPIProject
//
//  Created by Raj Saija on 14/04/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: Properties
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: Body -
    var body: some View {
//        TopHeadlinesNews() // For normal lazy view grid
        TopHeadlinesNewsWaterFallGrid()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

