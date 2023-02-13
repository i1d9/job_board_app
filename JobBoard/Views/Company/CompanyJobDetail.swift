//
//  CompanyJobDetail.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI

struct CompanyJobDetail: View {
    
    var job : MyCompanyJob
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
                                            applicant: application.applicant, cv: application.cv, job: job)){
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
                Button("Edit"){
                    
                }
            }
            
            ToolbarItem {
                Button("Delete"){
                    
                }
            }
            
        }
        
    }
}


struct CompanyJobDetail_Previews: PreviewProvider {
    static var previews: some View {
        CompanyJobDetail(job: MyCompanyJob(id: 0, name: "", status: "", type: "", description: "", environment: ""))
    }
}
