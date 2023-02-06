//
//  ContentView.swift
//  AiEmoj
//
//  Created by 顾艳华 on 2023/2/5.
//

import SwiftUI
import SwiftyJSON

struct ContentView: View {
    @State var prompt = ""
    @State var result = ""
    
    @State var showSettings = false
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading){
                    Text("🍾")
                        .font(.system(size: 96))
                    Text("Generate emojis by prompt")
                    Text("Copy and immediately use in your favorite apps!")
                }
 
                Section(header: Text("prompt")){
                    TextField("prompt", text: $prompt)
                }
                Section(header: Text("result")){
                    Text(result)
                }
                HStack {
                    Button {
                        DispatchQueue.global(qos: .background).async {
                            let url = URL(string: "https://www.emojai.app/api/generate")!
                            var request = URLRequest(
                                        url: url,
                                        cachePolicy: .reloadIgnoringLocalCacheData
                                    )
                                    
                            request.httpMethod = "POST"
                            let payload = ["emoji": prompt]
                            let json = JSON(payload)
                            request.httpBody = try! json.rawData()
                            
                            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                                guard let data = data else { return }
                                print(String(data: data, encoding: .utf8)!)
                                DispatchQueue.main.async {
                                    result = try! JSON(data: data)["result"].stringValue
                                }
                            }

                            task.resume()
                        }
                    }label: {
                        Text("Find")
                    }
                    .padding(.trailing)
                    
                    Button {
                        
                    }label: {
                        Image(systemName: "doc.on.doc")
                    }
                }
            }.toolbar {
                Button {
                    showSettings = true
                }label: {
                    Image(systemName: "gear")
                }
            }
            .sheet(isPresented: $showSettings){
                SettingsView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
