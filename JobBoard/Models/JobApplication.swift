//
//  Application.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation





struct MyApplication: Codable, Identifiable{
    
    var cv : CurriculumVitae
    var job : MyApplicationJob
    var id: Int
    var status: String
    
    
    private enum MyApplicationKeys : String, CodingKey {
        
        case cv = "cv",job = "job", id = "id", status = "status"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyApplicationKeys.self)
        self.cv = try container.decode(CurriculumVitae.self, forKey: .cv)
        self.job = try container.decode(MyApplicationJob.self, forKey: .job)
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




struct MyCompanyApplicationCV: Codable, Identifiable{
    var id : Int
    var url : String
    
    
    init(id : Int, url : String) {
        self.id = id
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

struct MyCompanyJobApplicant : Codable, Identifiable{
    
    var first_name : String
    var last_name : String
    var phone_number : String
    var email :String
    var id : Int
    var username: String
    
    init(id: Int,first_name: String, last_name:String, phone_number: String, email : String, username: String) {
        
        self.first_name = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.username = username
        self.email = email
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try container.decode(String.self, forKey: .first_name)
        self.last_name = try container.decode(String.self, forKey: .last_name)
        self.phone_number = try container.decode(String.self, forKey: .phone_number)
        self.email = try container.decode(String.self, forKey: .email)
        self.id = try container.decode(Int.self, forKey: .id)
        self.username = try container.decode(String.self, forKey: .username)
    }
}

struct MyCompanyApplication : Codable, Identifiable {
    
    var id : Int
    var status : String
    var cv : MyCompanyApplicationCV
    var applicant : MyCompanyJobApplicant
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.status = try container.decode(String.self, forKey: .status)
        self.cv = try container.decode(MyCompanyApplicationCV.self, forKey: .cv)
        self.applicant = try container.decode(MyCompanyJobApplicant.self, forKey: .applicant)
    }
}
