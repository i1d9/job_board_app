//
//  ProfileView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            
            HStack{
                Image(systemName: "person")
                
                VStack{
                    HStack{
                        Text(NetworkService.current_user!.first_name)
                        Text(NetworkService.current_user!.last_name)
                    }
                    Text(NetworkService.current_user!.email)

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
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
