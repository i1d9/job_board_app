//
//  ApplicationFileView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI
import PDFKit

struct ApplicationFileView: View {
    
    var application: MyCompanyApplication
    var applicant : MyCompanyJobApplicant
    var cv : MyCompanyApplicationCV
    var job : MyCompanyJob
    
    @State private var selectedData: Data?  = nil
    @State private var pdfDocument : PDFDocument? = nil
    
    
    private var service : NetworkService
    
    
    init(current_application: MyCompanyApplication,  job: MyCompanyJob) {
        
        
        
        

        
        self.application = current_application
        self.applicant = current_application.applicant
        self.cv = current_application.cv
        self.job = job
        self.service =  NetworkService()
    }
    var body: some View {
        
        VStack(alignment: .leading){
            Group{
                HStack{
                    Text(applicant.email)
                }
                
                HStack{
                    Text(applicant.phone_number)
                }
            }.padding(8)
            
            if pdfDocument != nil{
                
                PDFKitRepresentedView(selectedData!).frame(width: .infinity)
                
                
            }
            
            Spacer()
            
        
            
        }.navigationTitle("\(applicant.first_name) \(applicant.last_name)").toolbar{
            
            ToolbarItem{
                Button("Approve"){
                    
                    service.updateApplication(job: job.id, applicant_username: applicant.username, application_id: application.id, status: "accepted")
                    
                }.disabled(application.status == "accepted")
            }
            
            
            ToolbarItem{
                Button("Decline"){
                    service.updateApplication(job: job.id, applicant_username: applicant.username, application_id: application.id, status: "declined")
                    
                }.disabled(application.status == "declined")
            }
        }.task {
            do {
                
                
                let url = URL(string: "https://www.hackingwithswift.com/samples/messages.json")!
                
                if let (fileData,_) = try? await URLSession.shared.data(from: URL(string: "\(NetworkService().base_url)\(application.cv.url)")!){
                    
                    selectedData = fileData
                    pdfDocument = PDFDocument(data: fileData)
                }
            }
        }
    }
}

struct ApplicationFileView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        ApplicationFileView(
            
            current_application: MyCompanyApplication(id: 0, status: "", cv: MyCompanyApplicationCV(id: 0, url: ""), applicant: MyCompanyJobApplicant(id: 0, first_name: "John", last_name: "Doe", phone_number: "254712345678", email: "johndoe@example.com", username: "username")),  job: MyCompanyJob(id: 0, name: "", status: "", type: "", description: "", environment: ""))
    }
}
