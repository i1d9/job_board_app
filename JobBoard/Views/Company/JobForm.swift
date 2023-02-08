//
//  JobForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct JobForm: View {
    
    @State private var name = ""
    @State private var description = "Briefly describe the position"
    var types = ["Contract", "Consultancy","Internship","Long Term", "Short Term"]
    
    var environments = ["Remote", "On site", "Half Remote"]
    
    @State private var type = ""
    @State private var environment = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    TextField("Name", text: $name)
                    
                    TextEditor(text: $description)
                    
                    Picker("Job Type", selection: $type){
                        ForEach(types, id: \.self){type in
                            Text(type)
                        }
                    }
                    
                    Picker("Environment", selection: $environment){
                        ForEach(environments, id: \.self){env in
                            Text(env)
                        }
                    }
                    
                    
                }
            }
        }
    }
}

struct JobForm_Previews: PreviewProvider {
    static var previews: some View {
        JobForm()
    }
}
