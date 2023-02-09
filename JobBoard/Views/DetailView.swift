//
//  DetailView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import SwiftUI

struct DetailView: View {
    @State var job : Job
    
    @State var isPresented  = false
    
    private var network = NetworkService()
    
    
    init(job: Job) {
        self.job = job
        
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                
                HStack{
                    
                    AsyncImage(url: URL(string: "\(NetworkService().base_url)\(job.company!.logo!.large)")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 1)
                    }
                    .shadow(radius: 7).frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading){
                        Text(job.company!.name).font(.title)
                        Text(job.company!.address)
                        Text(job.company!.bio).font(.subheadline)
                    }
                    
                }
                Text(job.description).font(.title2)
                
                HStack{
                    Text(job.environment)
                    Text(job.type)
                }
                
                
                
                Button("Apply Now"){
                    isPresented = true
                }
                
                
                
            }.fullScreenCover(isPresented: $isPresented){
                JobApplicationForm(parsed_job: job)
            }
        }.navigationTitle(job.name)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(job: Job(id: 0, name: "", description: "", type: "", environment: "", status: ""))
    }
}
