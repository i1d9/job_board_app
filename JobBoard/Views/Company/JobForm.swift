//
//  JobForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct JobForm: View {
    
    @State private var name = ""
    @State private var description = "Briefly describe the position"
    var types = ["Contract", "Consultancy","Internship","Long Term", "Short Term"]
    
    var environments = ["Remote", "On site", "Half Remote"]
    
    @State private var type = "Contract"
    @State private var environment = "Remote"
    
    private var network = NetworkService()
    var body: some View {
        ScrollView{
            VStack{
                TextField("Name", text: $name)
                
                ZStack(alignment: .leading) {
                    if self.description.isEmpty {
                        VStack {
                            Text("Description")
                                .padding(.top, 8)
                                .padding(.leading, 1)
                            Spacer()
                        }
                    }
                    TextEditor(text: self.$description)
                    /* Set the background to that of the grouped background colour */
                        .background(Color(.secondarySystemGroupedBackground))
                    /* Allow the text overlay to be seen and emulate the necessary colour */
                        .opacity(self.description.isEmpty ? 0.7 : 1)
                }
                .frame(height: 125)
                
                
                Picker("Job Type", selection: $type){
                    ForEach(types, id: \.self){type in
                        Text(type)
                    }
                }
                
                Picker("Environment", selection: $environment){
                    ForEach(environments, id: \.self){env in
                        Text(env)
                    }
                }
                
                Button("Submit"){
                    network.createJob(name: name, description: description, type: type, environment: environment) { result in
                        result
                    }
                    
                }.buttonStyle(.borderedProminent)
                
                
            }.navigationTitle("New Job")
        }
        
    }
}

struct JobForm_Previews: PreviewProvider {
    static var previews: some View {
        JobForm()
    }
}
