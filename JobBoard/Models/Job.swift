//
//  Job.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct Job : Codable, Identifiable{
    
    var id : Int
    var name : String
    var description : String
    var company : Company? = nil
    var type : String //Contract/Long Term/Short Term/Internship/Consultancy
    var environment : String //Remote/Semi-remote/In-Office
    var status : String
    
    init(id: Int, name : String, description: String, type: String, environment: String, status: String){
        self.id = id
        self.name = name
        self.description = description
        self.type = type
        self.environment = environment
        self.status = status
    }
    
    
    private enum JobDataKeys: String, CodingKey {
            case id = "id"
            case attributes = "attributes"
            
            
            enum AttributeKeys : String, CodingKey {
                
                case name = "name",description = "description",company = "company",type="type",environment = "environment", status = "status"
            }
        }
    
    init(from decoder: Decoder) throws {
        
        
        let jobDataKeysContainer = try decoder.container(keyedBy: JobDataKeys.self)
        
        self.id = try jobDataKeysContainer.decode(Int.self, forKey: .id)
        
        
        let attributesContainer = try jobDataKeysContainer.nestedContainer(keyedBy: JobDataKeys.AttributeKeys.self, forKey: .attributes)
        
        self.name = try attributesContainer.decode(String.self, forKey: .name)
        
        self.description = try attributesContainer.decode(String.self, forKey: .description)
        //self.company = try jobDataKeysContainer.decode(Company.self, forKey: .company)
        self.type = try attributesContainer.decode(String.self, forKey: .type)
        self.environment = try attributesContainer.decode(String.self, forKey: .environment)
        self.status = try attributesContainer.decode(String.self, forKey: .status)
    }
    
}
