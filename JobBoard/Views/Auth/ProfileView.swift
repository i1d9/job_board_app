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
    var body: some View {
        NavigationView {
            VStack {
                
                HStack{
                    Image(systemName: "person")
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text(NetworkService.current_user!.first_name)
                            Text(NetworkService.current_user!.last_name)
                        }
                        Text(NetworkService.current_user!.email)

                    }
                  
                }
                
                
             
                
                
                NavigationLink( destination: ProfileForm()){
                    Text("My Profile")
                }
                
                Button(action: {
                    NetworkService.current_user = nil
                    AuthState.Authenticated.send(false)
                    KeychainHelper.standard.delete( service: "strapi_job_authentication_service",
                                                   account: "strapi_job_app")
                                     
                }, label: {
                    Text("Log out")
                })
                .navigationTitle("My Profile")
            }
        }.onAppear{
            network.my_profile{user in
                
                print(user)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
