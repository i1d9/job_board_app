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
                Text("Logo")
                
                VStack{
                    Text(job.name)
                    Text(job.environment)
                }
            }
            

        }
    }
}

struct JobCard_Previews: PreviewProvider {
    static var previews: some View {
        JobCard(job: Job(name: "Job Title", description: "", company: Company(name: "", phone: "", email: "", address: "", category: ""), type: "", environment: "Remote", status: ""))
    }
}
