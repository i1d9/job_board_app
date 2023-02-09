//
//  CompanyProfileView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct CompanyProfileView: View {
    var body: some View {
        
        
        List{
            NavigationLink(destination: CompanyForm()){
                Text("Edit Profile")
            }
          
            NavigationLink(destination: JobForm()){ Text("My Jobs")}
            
         
            
        }.navigationTitle(NetworkService.company!.name) .toolbar {
            ToolbarItem {
                Button("Delete Profile"){
                    print("Delete Profile")
                }
            }
        }
        
    }
}

struct CompanyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileView()
    }
}
