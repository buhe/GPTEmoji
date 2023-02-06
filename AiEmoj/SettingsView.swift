//
//  SettingsView.swift
//  Connectivity test
//
//  Created by 顾艳华 on 2023/2/3.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationStack {
            Form{
                Section(){
                    Button{
                        #if os(iOS)
                        if let url = URL(string: "https://github.com/buhe/PingPremium/issues") {
                            UIApplication.shared.open(url)
                        }
                        #endif
                    } label: {
                        
                        Text("Feedback")
                        
                    }.buttonStyle(PlainButtonStyle())
                    Button{
                        requestReview()
                    } label: {
                        
                        Text("Rate")
                        
                    }.buttonStyle(PlainButtonStyle())
                    
                    
                    HStack{
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.releaseVersionNumber!)
                    }
    
                }
               
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
