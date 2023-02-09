//
//  HomeView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct HomeView: View {
    
    
    private var network = NetworkService()
    
    static let tag: String? = "HomeView"
    @State private var jobs : [Job] = []
    var body: some View {
        NavigationView{
            
            
            List(jobs) { job in
                NavigationLink {
                    DetailView(job: job)
                } label: {
                    JobCard(job: job)
                }
            }.onAppear{
                network.listJobs{fetched_jobs in
                    jobs = fetched_jobs
                    
                }
                
                network.loadMyCompanyProfile{company_profile in
                    
                    if company_profile != nil{
                        
                        KeychainHelper.standard.save(company_profile, service: "strapi_job_company_service",
                                                     account: "strapi_job_app")
                        NetworkService.company = company_profile
                        AuthState.Company.send(true)
                    }
                    
                    
                }
                
            }
            .navigationTitle("Jobs")
            
        }}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
