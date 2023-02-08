//
//  NetworkModels.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import Foundation
import PhotosUI


struct AuthenticationResponse :  Codable{
    
    var user : User
    
    enum AuthResponseKeys: String, CodingKey {
        case jwt = "jwt"
        case user = "user"
        
        enum UserDetailsKeys : String, CodingKey {
        case id = "id", username = "username", email = "email", first_name = "first_name", last_name = "last_name", phone_number = "phone_number"
        }
    }
    
    init(from decoder: Decoder) throws {
        let authReponseContainer = try decoder.container(keyedBy: AuthResponseKeys.self)
        let userDetailsContainer = try authReponseContainer.nestedContainer(keyedBy: AuthResponseKeys.UserDetailsKeys.self, forKey: .user)
        
        let id = try userDetailsContainer.decode(Int.self, forKey: .id)
        let phone_number = try userDetailsContainer.decode(String.self, forKey: .phone_number)
        let username = try userDetailsContainer.decode(String.self, forKey: .username)
        let first_name = try userDetailsContainer.decode(String.self, forKey: .first_name)
        let last_name = try userDetailsContainer.decode(String.self, forKey: .last_name)
        let email = try userDetailsContainer.decode(String.self, forKey: .email)
        let jwt = try authReponseContainer.decode(String.self, forKey: .jwt)
        
        self.user = User(username: username, id: id, phone_number: phone_number, email: email, first_name: first_name, last_name: last_name, token: jwt )
        
    }
    
}


struct MyProfileResponse:Codable{
    var user: User
    
    enum UserDetailsKeys : String, CodingKey {
    case id = "id", username = "username", email = "email", first_name = "first_name", last_name = "last_name", phone_number = "phone_number",role = "role", profile = "profile"
    }
    
    
    init(from decoder: Decoder) throws {
        let userDetailsContainer = try decoder.container(keyedBy: UserDetailsKeys.self)
        
        let id = try userDetailsContainer.decode(Int.self, forKey: .id)
        let phone_number = try userDetailsContainer.decode(String.self, forKey: .phone_number)
        let username = try userDetailsContainer.decode(String.self, forKey: .username)
        let first_name = try userDetailsContainer.decode(String.self, forKey: .first_name)
        let last_name = try userDetailsContainer.decode(String.self, forKey: .last_name)
        let email = try userDetailsContainer.decode(String.self, forKey: .email)
        
        let role = try userDetailsContainer.decode(Role.self, forKey: .role)
        // let profile = try userDetailsContainer.decode(ProfileImage.self, forKey: .profile) Crashes the app if they dont have a dp

        
        self.user = User(username: username, id: id, phone_number: phone_number, email: email, first_name: first_name, last_name: last_name, token: NetworkService.current_user!.token,  role: role )
        
        
    }
    
    
}


struct BulkJobServerResponse: Decodable {
    
    var data : [Job]
    
    
    enum DataKeys: CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataKeys.self)
        
        self.data = try container.decode([Job].self, forKey: .data)
        
    }
    
}

struct UploadImage {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}



extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
