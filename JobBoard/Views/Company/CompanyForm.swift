//
//  CompanyForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 08/02/2023.
//

import SwiftUI

struct CompanyForm: View {
    
    
    
    @State private var name = ""
    @State private var address = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var category = "Finance"
    var categories = ["Finance", "Technology", "Insurance", "Hospitality", "Health Care", "Non Governmental Organization"]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    
                    TextField("Name", text: $name)
                    TextField("Address", text: $address)
                    TextField("Email", text: $email)
                    TextField("Phone Number", text: $phone)
                    
                    
                    Picker("Category", selection: $category) {
                                    ForEach(categories, id: \.self) {
                                        Text($0)
                    }
                    }.pickerStyle(WheelPickerStyle())
                    
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
