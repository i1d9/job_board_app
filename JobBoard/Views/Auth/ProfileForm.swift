//
//  ProfileForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import SwiftUI
import PhotosUI

struct ProfileForm: View {
    
    @State var first_name : String = NetworkService.current_user!.first_name
    @State var last_name : String = NetworkService.current_user!.last_name
    @State var email : String = NetworkService.current_user!.email
    @State var username : String = NetworkService.current_user!.username
    
    @State var phone_number : String = NetworkService.current_user!.phone_number
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var imageBase : String? = nil
    
    private var network = NetworkService()
    var body: some View {
        NavigationView {
            VStack{
                
                
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text("Upload Profile Image")
                        }
                        
                    }.onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrive selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                }
                
                TextField("First Name", text: $first_name)
                TextField("Last Name", text: $last_name)
                TextField("Username", text: $username)
                TextField("Email Address", text: $email)
                TextField("Phone Number", text: $phone_number)
                
                
                
                Button(action: {
                    
                    if selectedImageData != nil {
                        
                        network.updateProfile(selectedImageData: selectedImageData,username: username, first_name: first_name, last_name: last_name, email: email, phone_number: phone_number){user in
                            
                            print("Image uploaded?")
                            print(user)
                        }
                    }else{
                        network.updateProfile(username: username, first_name: first_name, last_name: last_name, email: email, phone_number: phone_number){user in
                            
                            print(user)
                        }
                    }
                }, label: {
                    Text("Save")
                })
                
            }
            
        }
    }
}

struct ProfileForm_Previews: PreviewProvider {
    static var previews: some View {
        ProfileForm()
    }
}
