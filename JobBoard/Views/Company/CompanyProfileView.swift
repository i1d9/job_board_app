//
//  CompanyProfileView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct CompanyProfileView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    NavigationLink(destination: CompanyForm()){
                        Text("Edit Profile")
                    }
                    NavigationLink(destination: JobForm()){
                        Text("Add Job")
                        
                    }
                    NavigationLink(destination: JobForm()){ Text("My Jobs")}
                    
                }
            }.navigationTitle("Company Title")
        }
    }
}

struct CompanyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileView()
    }
}
