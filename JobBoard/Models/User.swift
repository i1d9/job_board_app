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
    var email : String
    var first_name : String
    var last_name : String
    var token : String
    var role : String = ""
    var profile : String = ""
}


struct AuthState{
    static let Authenticated = PassthroughSubject<Bool, Never>()
    static func IsAuthenticated() -> Bool {
        
        let user = KeychainHelper.standard.read(service: "strapi_job_service",
                                            account: "strapi_job_app",
                                            type: User.self)
            
    NetworkService.current_user = user
    return user != nil
    }
}

