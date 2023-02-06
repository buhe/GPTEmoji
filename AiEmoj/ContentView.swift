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
    @State var loading = false
    
    @State var showSettings = false
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading){
                    Text("🍾")
                        .font(.system(size: 96))
                    Text("Generate emojis according to the prompt words")
                    Text("Copy and immediately use in your favorite apps!")
                }
 
                Section(header: Text("prompt")){
                    TextField("prompt", text: $prompt)
                        .disableAutocorrection(true)
                    #if os(iOS)
                        .textInputAutocapitalization(.never)
                    #endif
                }
                Section(header: Text("result")){
                    Text(result)
                }
                HStack {
                    Button {
                        loading.toggle()
                        DispatchQueue.global(qos: .background).async {
                            let url = URL(string: "https://www.emojai.app/api/generate")!
                            var request = URLRequest(
                                        url: url,
                                        cachePolicy: .reloadIgnoringLocalCacheData
                                    )
                                    
                            request.httpMethod = "POST"
                            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            request.addValue("application/json", forHTTPHeaderField: "Accept")

                            let payload = ["emoji": prompt]
                            
                            let json = JSON(payload)
                            print(json)
                            request.httpBody = try! json.rawData()
                            
                            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                                if let error = error {
                                    print(error)
                                    loading.toggle()
                                }
                                guard let data = data else { return }
                                print(String(data: data, encoding: .utf8)!)
                                DispatchQueue.main.async {
                                    loading.toggle()
                                    result = try! JSON(data: data)["result"].stringValue
                                }
                            }

                            task.resume()
                        }
                    }label: {
                        Text(loading ? "Finding" : "Find")
                    }
                    .padding(.trailing)
                    .disabled(loading)
                    
                  
                }
            }.toolbar {
                Button {
                    #if os(iOS)
                        UIPasteboard.general.string = result
                    #endif
                }label: {
                    Image(systemName: "doc.on.doc")
                }
                
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
