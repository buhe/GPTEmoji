//
//  HistoryViewModel.swift
//  AiEmoj
//
//  Created by 顾艳华 on 2023/2/9.
//

import Foundation
import CoreData
import SwiftUI

class HistoryViewModel: ObservableObject {
    func day(items: FetchedResults<Item>) -> [Day] {
        []
    }
}

struct Day: Identifiable {
    var id: String
    let date: String
    let emojis: [String]
    
}
