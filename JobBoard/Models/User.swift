//
//  User.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation
import Combine

struct User: Codable{
    var username : String
    var id : Int
    var phone_number : String
    var email : String
    var first_name : String
    var last_name : String
    var token : String
    var profile : String = ""
    
    
}

struct Role: Codable{
    var name : String
    var description: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
    }
}


struct AuthState{
    static let Authenticated = PassthroughSubject<Bool, Never>()
    static func IsAuthenticated() -> Bool {
        
        
    let user = KeychainHelper.standard.read( service: "strapi_job_authentication_service",
                                                 account: "strapi_job_app",
                                            type: User.self)
            
    NetworkService.current_user = user
    return user != nil
    }
}


