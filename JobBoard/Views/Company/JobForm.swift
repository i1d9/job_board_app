//
//  JobForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct JobForm: View {
    
    @State var job : Job = Job(id: 0, name: "", description: "", type: "", environment: "", status: "")
    
    init(job: Job){
        self.job = job
    }
    
    
    @State private var name = ""
    @State private var description = "Briefly describe the position"
    var types = [
        "Contract",
        "Consultancy",
        "Internship",
        "Long Term",
        "Short Term"
    ]
    
    var environments = ["Remote", "On site", "Half Remote"]
    
    @State private var type = "Contract"
    @State private var environment = "Remote"
    
    @Environment(\.dismiss) private var dismiss
    private var network = NetworkService()
    var body: some View {
        ScrollView{
            VStack{
                TextField("Name", text: $job.name)
                
                ZStack(alignment: .leading) {
                    if self.description.isEmpty {
                        VStack {
                            Text("Description")
                                .padding(.top, 8)
                                .padding(.leading, 1)
                            Spacer()
                        }
                    }
                    TextEditor(text: self.$job.description)
                    /* Set the background to that of the grouped background colour */
                        .background(Color(.secondarySystemGroupedBackground))
                    /* Allow the text overlay to be seen and emulate the necessary colour */
                        .opacity(self.job.description.isEmpty ? 0.7 : 1)
                }
                .frame(height: 125)
                
                
                Picker("Job Type", selection: $job.type){
                    ForEach(types, id: \.self){type in
                        Text(type)
                    }
                }
                
                Picker("Environment", selection: $job.environment){
                    ForEach(environments, id: \.self){env in
                        Text(env)
                    }
                }
                
                Button("Submit"){
                    
                    if(self.job.id == 0){
                        network.createJob(name: name, description: description, type: type, environment: environment) { inserted_job in
                            
                            if inserted_job != nil{
                                dismiss()
                            }
                        }
                        
                    }else{
                        
                        network.editJob(id: self.job.id, name: self.job.name, description: self.job.description, type: self.job.type, environment: self.job.environment){update_job in
                            
                            if update_job != nil{
                                dismiss()
                            }
                        }
                        
                    }
                    
                }.buttonStyle(.borderedProminent)
                
                
            }.navigationTitle("Job Details")
        }
        
    }
}

struct JobForm_Previews: PreviewProvider {
    
    
    static var previews: some View {
        JobForm(job: Job(id: 0, name: "", description: "", type: "", environment: "", status: ""))
    }
}
