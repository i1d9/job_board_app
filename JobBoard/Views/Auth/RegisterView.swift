//
//  RegisterView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct RegisterView: View {
    
    var selectedTypes = ["Company", "Individual"]
    @State private var selectedType = "Individual"
    
    @State private var first_name : String = ""
    @State private var last_name : String = ""
    @State private var phone_number: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    var network = NetworkService()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            
            Text("Get Started!").font(.title)
            
            TextField("First Name", text: $first_name)
            TextField("Last Name", text: $last_name)
            TextField("Email Address", text: $email)
            TextField("Username", text: $username)
            TextField("Phone", text: $phone_number)
            SecureField("Password", text: $password)
            
            Picker("Account Type", selection: $selectedType) {
                ForEach(selectedTypes, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            Button(action: {
                network.register(first_name: first_name, last_name: last_name, username: username, email: email, phone: phone_number, password: password){
                    user in
                    
                    if user != nil{
                        AuthState.Authenticated.send(true)
                    }
                    
                }
            }, label: {
                Text("Create account")
            })
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Already have an account?Login")
            })
            
        }.textFieldStyle(.roundedBorder).buttonStyle(.borderedProminent).padding(16)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
