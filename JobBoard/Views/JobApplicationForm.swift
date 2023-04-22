//
//  JobApplicationForm.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 09/02/2023.
//

import SwiftUI
import PDFKit


struct PDFKitRepresentedView: UIViewRepresentable {
    typealias UIViewType = PDFView
    
    let data: Data
    let singlePage: Bool
    
    init(_ data: Data, singlePage: Bool = false) {
        self.data = data
        self.singlePage = singlePage
    }
    
    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }
    
    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {
        pdfView.document = PDFDocument(data: data)
    }
}


struct JobApplicationForm: View {
    
    
    @State private var openCVFile : Bool = false
    @State private var selectedData: Data?  = nil
    @State private var pdfDocument : PDFDocument? = nil
    @State private var pdfDocumentURL : URL? = nil
    @State private var applicationProgressAlert = false
    
    var job : Job
    
    private var network = NetworkService()
    
    @Environment(\.dismiss) var dismiss

        
    init(parsed_job: Job) {
        
        job = parsed_job
    }
    
    var body: some View {
        
        NavigationStack{
            VStack(alignment: .leading){
                
                HStack{
                    
                    Text(NetworkService.current_user!.first_name)
                    Text(NetworkService.current_user!.last_name)
                }
                Text(NetworkService.current_user!.email)
                Text(NetworkService.current_user!.phone_number)
                
                Button("Upload Your CV"){
                    
                    openCVFile = true
                    
                }.fileImporter(isPresented: $openCVFile, allowedContentTypes: [.pdf],   allowsMultipleSelection: false){ result in
                    switch result {
                    case .success(let file_paths):
                        
                        let fileUrl = file_paths.first
                        pdfDocumentURL = fileUrl
                        guard fileUrl!.startAccessingSecurityScopedResource() else { return }
                        if let fileData = try? Data(contentsOf: fileUrl!){
                            
                            selectedData = fileData
                            pdfDocument = PDFDocument(data: fileData)
                        }
                        fileUrl!.stopAccessingSecurityScopedResource()
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                }
                
                if pdfDocument != nil{
                    
                    PDFKitRepresentedView(selectedData!).frame(width: .infinity, height: 250)
                    
                    Button("Submit Application"){
                        network.createApplication(selectedImageData: selectedData!, job: job.id){
                            result in
                            
                            applicationProgressAlert = true
                           
                        }
                    }.alert("Your application is being processed", isPresented: $applicationProgressAlert) {
                        Button("OK", role: .cancel) {
                            dismiss()
                        }
                    }
                }
                
                Spacer()
                
            }.toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct JobApplicationForm_Previews: PreviewProvider {
    static var previews: some View {
        JobApplicationForm(parsed_job: Job(id: 0, name: "Job Name", description: "Job Description", type: "Job Type", environment: "Job Environment", status: "Job Status"))
    }
}
