//
//  CompanyJob.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI

struct CompanyJob: View {
    
    private var network = NetworkService()
    
    @State private var jobs : [MyCompanyJob] = []
    var body: some View {
       
            List(jobs) { job in
                
                NavigationLink(destination: CompanyJobDetail(job: job)){
                    Text(job.name)
                }
                
            }.navigationBarTitle("My Jobs").toolbar {
                ToolbarItem {
                 
                    
                    NavigationLink("Add"){
                        
                        JobForm(job: Job(id: 0, name: "", description: "", type: "", environment: "", status: ""))
                    }                }
                
            }.onAppear{
                network.listMyJobs{company_jobs in
                    
                    jobs = company_jobs
                    
                    
                    
                }
        
        }
    }
}

struct CompanyJob_Previews: PreviewProvider {
    static var previews: some View {
        CompanyJob()
    }
}
