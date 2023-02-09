//
//  ContentView.swift
//  AiEmoj
//
//  Created by 顾艳华 on 2023/2/5.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let viewModel: HistoryViewModel
    
    var body: some View {
        TabView {
            GetEmojiView()
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    VStack {
                        Image(systemName: "face.smiling")
                        Text("Find")
                    }
                }
            HistoryView(viewModel: viewModel)
                .environment(\.managedObjectContext, viewContext)
                .tabItem {
                    VStack {
                        Image(systemName: "clock")
                        Text("Historys")
                    }
                }
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HistoryViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
