//
//  HistoryView.swift
//  AiEmoj
//
//  Created by 顾艳华 on 2023/2/9.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var items: FetchedResults<Item>
    @ObservedObject var viewModel: HistoryViewModel
    var body: some View {
        List {
            ForEach(viewModel.day(items:items)) {
                item in
                DayView(day: item)
            }
        }
    }
}

struct DayView: View {
    let day: Day
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: HistoryViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
