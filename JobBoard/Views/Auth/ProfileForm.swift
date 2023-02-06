//
//  ProfileForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import SwiftUI

struct ProfileForm: View {
    
    @State var first_name : String = ""
    @State var last_name : String = ""
    @State var email : String = ""
    @State var username : String = ""
    var body: some View {
        VStack{
            
            
            TextField("First Name", text: $first_name)
            TextField("Last Name", text: $last_name)
            TextField("Username", text: $username)
            TextField("Email Address", text: $email)
            
            
            
            Button(action: {
                
            }, label: {
                Text("Save")
            })
            
        }
    }
}

struct ProfileForm_Previews: PreviewProvider {
    static var previews: some View {
        ProfileForm()
    }
}
