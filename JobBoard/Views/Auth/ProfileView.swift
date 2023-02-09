//
//  ProfileView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct ProfileView: View {
    
    
    static let tag: String? = "ProfileView"
    
    private var network = NetworkService()
    
    @State private var username = ""
    @State private var email = ""
    @State private var first_name = ""
    @State private var last_name = ""
    
    @State var isCompany = AuthState.IsCompany()
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                
                HStack{
                    Image(systemName: "person")
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(first_name)
                            Text(last_name)
                        }
                        Text(email)
                        
                    }
                    
                }
                
                List{
                    NavigationLink( destination: ProfileForm()){
                        Text("My Profile")
                    }
                    
                    if isCompany{
                        NavigationLink( destination: CompanyProfileView()){
                            Text("Company Profile")
                        }
                    }else{
                        NavigationLink( destination: AcademicForm()){
                            Text("My Documents")
                        }
                        
                        NavigationLink( destination: ProfileForm()){
                            Text("My Applications")
                        }
                    }
                    
                    Button(action: {
                        NetworkService.current_user = nil
                        AuthState.Authenticated.send(false)
                        KeychainHelper.standard.delete( service: "strapi_job_authentication_service",
                                                        account: "strapi_job_app")
                        
                    }, label: {
                        Text("Log out")
                    })
                }
                
               
                
                
                
                
                
             
                .navigationTitle("My Profile")
            }
        }.onAppear{
            network.my_profile{user in
                username = user.username
                email = user.email
                first_name = user.first_name
                last_name = user.last_name
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
