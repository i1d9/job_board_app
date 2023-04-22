//
//  CompanyJobDetail.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI

struct CompanyJobDetail: View {
    
    var job : MyCompanyJob
    @Environment(\.dismiss) private var dismiss
    
    private var network = NetworkService()
    
    init(job: MyCompanyJob, network: NetworkService = NetworkService()) {
        self.job = job
        self.network = network
    }
    
    var body: some View {
        VStack{
            
            Form{
                Section{
                    Text(job.description)
                    Text(job.type)
                    Text(job.environment)
                }
                
                Section("Applicants"){
                    List(job.applications){application in
                        
                        
                        NavigationLink(destination:
                                        
                                        ApplicationFileView(
                                            current_application: application, job: job)){
                                HStack{
                                    Text(application.applicant.first_name)
                                    Text(application.applicant.last_name)
                                }
                            }
                        
                    }
                }
            }
        }.navigationTitle(job.name).toolbar {
            ToolbarItem {
              
                
                NavigationLink("Edit"){
                    JobForm(job: Job(id: job.id, name: job.name, description: job.description, type: job.type, environment: job.environment, status: job.status))
                }
            }
            
            ToolbarItem {
                Button("Delete"){
                    network.deleteJob(job_id: job.id){job in
                        if job != nil{
                            dismiss()
                        }
                        
                }}
            }
            
        }
        
    }
}


struct CompanyJobDetail_Previews: PreviewProvider {
    static var previews: some View {
        CompanyJobDetail(job: MyCompanyJob(id: 0, name: "", status: "", type: "", description: "", environment: ""))
    }
}
