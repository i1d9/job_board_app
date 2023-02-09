//
//  ApplicationFileView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI

struct ApplicationFileView: View {
    
    var applicant : MyCompanyJobApplicant
    var cv : MyCompanyApplicationCV
    var body: some View {
        
        VStack{
            HStack{
                Text(applicant.email)
            }
            
            HStack{
                Text(applicant.phone_number)
            }
            
        }.navigationTitle("\(applicant.first_name) \(applicant.last_name)").toolbar{
            
            ToolbarItem{
                Button("Approve"){
                    
                }
            }
            
            
            ToolbarItem{
                Button("Decline"){
                    
                }
            }
        }
    }
}

struct ApplicationFileView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationFileView(applicant: MyCompanyJobApplicant(id: 0, first_name: "", last_name: "", phone_number: "", email: ""), cv: MyCompanyApplicationCV(id: 0, url: ""))
    }
}
