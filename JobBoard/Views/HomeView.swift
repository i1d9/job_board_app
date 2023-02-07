//
//  HomeView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct HomeView: View {
    
    
    private var network = NetworkService()
    
    @State private var jobs : [Job] = []
    var body: some View {
        ScrollView{
            VStack{
                
                ForEach(jobs, id: \.id) { job in
                
                    
                    JobCard(job: job)
                }
            }
        }.onAppear{
            
            network.listJobs{fetched_jobs in

                jobs = fetched_jobs
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
