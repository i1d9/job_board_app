//
//  DetailView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import SwiftUI

struct DetailView: View {
    @State var job : Job
    var body: some View {
        ScrollView{
            VStack{
                
                Text(job.description)
                Text(job.environment)
                Text(job.type)
                
                Button("Apply Now"){
                    
                }
            }
        }.navigationTitle(job.name)
    
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(job: Job(id: 0, name: "", description: "", type: "", environment: "", status: ""))
    }
}
