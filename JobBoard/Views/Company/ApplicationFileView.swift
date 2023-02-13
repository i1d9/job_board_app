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
    var job : MyCompanyJob
    
    
    private var service : NetworkService
    
    
    init(applicant: MyCompanyJobApplicant, cv: MyCompanyApplicationCV, job: MyCompanyJob) {
        self.applicant = applicant
        self.cv = cv
        self.job = job
        self.service =  NetworkService()
    }
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
                    service.updateApplication(job: job.id, applicant_username: applicant.username, application_id: applicant.id, status: "accepted")
                    
                }
            }
            
            
            ToolbarItem{
                Button("Decline"){
                    service.updateApplication(job: job.id, applicant_username: applicant.username, application_id: applicant.id, status: "declined")
                    
                }
            }
        }
    }
}

struct ApplicationFileView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        ApplicationFileView(applicant: MyCompanyJobApplicant(id: 0, first_name: "John", last_name: "Doe", phone_number: "254712345678", email: "johndoe@example.com", username: "username"), cv: MyCompanyApplicationCV(id: 0, url: ""), job: MyCompanyJob(id: 0, name: "", status: "", type: "", description: "", environment: ""))
    }
}
