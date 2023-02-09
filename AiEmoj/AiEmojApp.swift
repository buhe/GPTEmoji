//
//  AiEmojApp.swift
//  AiEmoj
//
//  Created by 顾艳华 on 2023/2/5.
//

import SwiftUI

@main
struct AiEmojApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let viewModel = HistoryViewModel()
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
