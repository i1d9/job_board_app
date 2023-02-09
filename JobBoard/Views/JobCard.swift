//
//  JobCard.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import SwiftUI

struct JobCard: View {
    
    var job : Job
    var body: some View {
        VStack{
            
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
                    Text(job.name)
                    Text(job.environment)
                }
            }
            
            
        }
    }
}

struct JobCard_Previews: PreviewProvider {
    static var previews: some View {
        JobCard(job: Job(id: 0,name: "Job Title", description: "", type: "", environment: "Remote", status: ""))
    }
}
