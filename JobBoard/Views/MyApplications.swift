//
//  AcademicForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 07/02/2023.
//

import SwiftUI
import PDFKit

struct MyApplications: View {
    
    
    @State private var applications : [MyApplication] = []
    
    
    private var network = NetworkService()
    var body: some View {
        
        
        
        List(applications) { application in
            
            VStack{
                
                HStack{
                    
                    
                    AsyncImage(url: URL(string: "\(NetworkService().base_url)\(application.job.company.logo.url)")) { image in
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
                        Text(application.job.name)
                        Text(application.job.environment)
                    }
                }
                
                
            }
            
        }
        
        
        
        .onAppear{
            network.myApplications{applications in
                self.applications = applications
                
            }
            
        }.navigationTitle("My Applications")
        
    }
}

struct MyApplications_Previews: PreviewProvider {
    static var previews: some View {
        MyApplications()
    }
}
