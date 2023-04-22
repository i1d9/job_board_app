//
//  JobForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct JobForm: View {
    
    @State var job : Job
    
   
    
    @State private var showingAlert = false
    
    @State  var name = ""
    @State  var message = ""
    @State  var description = "Briefly describe the position"
    var types = [
        "Contract",
        "Consultancy",
        "Internship",
        "Long Term",
        "Short Term"
    ]
    
    var environments = ["Remote", "On site", "Half Remote"]
    
    @State  var type = "Contract"
    @State  var environment = "Remote"
    
    
    
    @Environment(\.dismiss)  var dismiss
    @Environment(\.presentationMode) var presentationMode
     var network = NetworkService()
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
                        network.createJob(name: self.job.name, description: self.job.description, type:  self.job.type, environment: self.job.environment) { inserted_job in
                            
                            if inserted_job != nil{
                                
                                
                                showingAlert = true
                                message = "Successfully created the job posting"
                                
                                
                            }
                        }
                        
                    }else{
                        
                        network.editJob(id: self.job.id, name: self.job.name, description: self.job.description, type: self.job.type, environment: self.job.environment){update_job in
                            
                            if update_job != nil{
                                showingAlert = true
                                message = "Successfully update the job posting"
                                
                            
                            }
                        }
                        
                    }
                    
                }.buttonStyle(.borderedProminent) .alert(message, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                }
                
                
            }.navigationTitle("Job Details").padding(16)
        }
        
    }
}

//struct JobForm_Previews: PreviewProvider {
//
//
//    static var previews: some View {
//        JobForm(job: .constant(Job(id: 0, name: "", description: "", type: "", environment: "", status: "")).projectedValue)
//    }
//}
