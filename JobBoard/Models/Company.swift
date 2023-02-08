//
//  Company.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct Company : Codable{
    var id: Int
    var name : String
    var phone : String
    var email : String
    var address : String
    var category : String //Tech/Pharma/Transport/NGO/Finance
    var bio: String
    
    private enum CompanyKeys : String, CodingKey {
        
        case name = "name",phone = "phone",email = "email",address = "address",category = "category",bio = "bio",id = "id"

        
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CompanyKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.category = try container.decode(String.self, forKey: .category)
        self.bio = try container.decode(String.self, forKey: .bio)
  
    }
    
}



struct CompanyLogo : Codable{
    
    var thumbnail : String
    var small : String
    var medium : String
    var large : String
    
    
    
}
