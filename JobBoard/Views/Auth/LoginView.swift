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
            
            Text("Welcome Back").font(.title)
            
            
            Group{
                TextField("Username or Email Address", text: $identifier).textFieldStyle(.roundedBorder)
                TextField("Password", text: $password).textFieldStyle(.roundedBorder)
                
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
                }).buttonStyle(.borderedProminent)
                
                Button(action: {
                    isRegisterPresented = true
                }, label: {
                    Text("Create an account")
                }).buttonStyle(.borderedProminent)
                
            }.padding(16)
            
            
            
            
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
