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
            ScrollView{
                VStack{
                    
                    
                    
            
                    
                }.onAppear{
                    network.myApplications{applications in
                        self.applications = applications
                    }
                }
            }.navigationTitle("My Applications")
        
    }
}

struct MyApplications_Previews: PreviewProvider {
    static var previews: some View {
        MyApplications()
    }
}
