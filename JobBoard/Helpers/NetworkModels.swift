//
//  NetworkModels.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import Foundation


struct AuthenticationResponse :  Codable{
    
    var user : User
    
    enum AuthResponseKeys: String, CodingKey {
        case jwt = "jwt"
        case user = "user"
        
        enum UserDetailsKeys : String, CodingKey {
        case id = "id", username = "username", email = "email", first_name = "first_name", last_name = "last_name"
        }
    }
    
    init(from decoder: Decoder) throws {
        let authReponseContainer = try decoder.container(keyedBy: AuthResponseKeys.self)
        let userDetailsContainer = try authReponseContainer.nestedContainer(keyedBy: AuthResponseKeys.UserDetailsKeys.self, forKey: .user)
        
        let id = try userDetailsContainer.decode(Int.self, forKey: .id)
        let username = try userDetailsContainer.decode(String.self, forKey: .username)
        let first_name = try userDetailsContainer.decode(String.self, forKey: .first_name)
        let last_name = try userDetailsContainer.decode(String.self, forKey: .last_name)
        let email = try userDetailsContainer.decode(String.self, forKey: .email)
        let jwt = try authReponseContainer.decode(String.self, forKey: .jwt)
        
        self.user = User(username: username, id: id, email: email, first_name: first_name, last_name: last_name, token: jwt)
        
    
        
        
    }
    
}