//
//  CompanyJob.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI

struct CompanyJob: View {
    
    private var network = NetworkService()
    @State private var visibleJobForm = false
    @State private var jobs : [MyCompanyJob] = []
    var body: some View {
       
            List(jobs) { job in
                
                NavigationLink(destination: CompanyJobDetail(job: job)){
                    Text(job.name)
                }
                
            }.sheet(isPresented: $visibleJobForm){
                
                JobForm(job: Job(id: 0, name: "Job Title", description: "Job Description", type: "", environment: "", status: "initiated"))
                
            }.navigationBarTitle("My Jobs").toolbar {
                ToolbarItem {
                    
                    
                    Button("Add"){
                        visibleJobForm = true
                    }
                }
                
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
