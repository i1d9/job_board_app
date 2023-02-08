//
//  LoginView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var identifier : String = ""
    @State private var password : String = ""
    @State private var isRegisterPresented = false
    var network = NetworkService()
    
    var body: some View {
        
        VStack{
            
            Text("Welcome Back")
            TextField("Username or Email Address", text: $identifier)
            TextField("Password", text: $password)
            
            Button(action: {
                network.login(identifier: identifier,  password: password){
                    user in
                    
                    if user != nil{
                        
                        KeychainHelper.standard.save(user, service: "strapi_job_authentication_service",
                                                     account: "strapi_job_app")
                        AuthState.Authenticated.send(true)
                    }
                }
            }, label: {
                Text("Login")
            })
            
            
            Button(action: {
                
                isRegisterPresented = true
            }, label: {
                Text("Create an account")
            })
            
            
            
            
        }.fullScreenCover(isPresented: $isRegisterPresented){
            RegisterView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
