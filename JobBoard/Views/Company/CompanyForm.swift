//
//  CompanyForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 08/02/2023.
//

import SwiftUI
import PhotosUI

struct CompanyForm: View {
    
    
    
    @State private var name = ""
    @State private var address = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var category = "Finance"
    @State private var bio = "Describe the company"
    var categories = ["Finance", "Technology", "Insurance", "Hospitality", "Health Care", "Non Governmental Organization"]
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var imageBase : String? = nil
    
    
    private var network = NetworkService()
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    
                    TextField("Name", text: $name)
                    TextField("Address", text: $address)
                    TextField("Email", text: $email)
                    TextField("Phone Number", text: $phone)
                    TextEditor(text: $bio)
                    
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
                    
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            
                            HStack {
                                Image(systemName: "photo.on.rectangle")
                                Text("Upload Logo")
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
                    
                    Button("Submit"){
                        
                        network.createCompany(selectedImageData: selectedImageData, name: name,address: address, email: email, phone: phone, bio: bio, category: category){
                            company in
                            
                            
                            if company != nil {
                                //TODO: Display sheet and navigate to the home view
                            }else{
                                //TODO: Display error sheet and reset fields
                            }
                            
                        }
                    }.padding(16).background(.red)
                }
            }.navigationTitle("Company Info")
        }
    }
}

struct CompanyForm_Previews: PreviewProvider {
    static var previews: some View {
        CompanyForm()
    }
}
