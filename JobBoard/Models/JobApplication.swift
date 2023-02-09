//
//  Application.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation





struct MyApplication: Codable, Identifiable{
    
    var cv : CurriculumVitae
    var job : Job
    var id: Int
    var status: String
    
    
    private enum MyApplicationKeys : String, CodingKey {
        
        case cv = "cv",job = "job", id = "id", status = "status"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyApplicationKeys.self)
        self.cv = try container.decode(CurriculumVitae.self, forKey: .cv)
        self.job = try container.decode(Job.self, forKey: .job)
        self.id = try container.decode(Int.self, forKey: .id)
        self.status = try container.decode(String.self, forKey: .status)
    }
}


struct CurriculumVitae : Codable, Identifiable{
    var id : Int
    var url : String
    
    
    private enum CurriculumVitaeKeys : String, CodingKey {
        
        case url = "url",id = "id"
        
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurriculumVitaeKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.id = try container.decode(Int.self, forKey: .id)
    }
    
}
struct JobApplication: Codable, Identifiable {
    
    var id : Int
    var applicant : User
    var job : Job
    var cv: CurriculumVitae
    var status : String
    
    
    
}
