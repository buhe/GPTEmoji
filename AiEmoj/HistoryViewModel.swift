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
        var result: [String:Day] = [:]
        for item in items {
            let key = itemFormatter.string(from: item.timestamp!)
            if result[key] == nil {
                result[key] = Day(id: key, date: key, emojis: [item.emoji!])
                print(key)
            } else {
                result[key]!.emojis.append(item.emoji!)
            }
        }
        return Array(result.values)
    }
}

struct Day: Identifiable {
    var id: String
    let date: String
    var emojis: [String]
    
}
