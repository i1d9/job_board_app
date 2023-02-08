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
                                print(jobs)
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
