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
    var logo : CompanyLogo?
    
    init(id: Int, name: String, phone: String, email: String, address: String, category: String, bio: String, logo: CompanyLogo?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.address = address
        self.category = category
        self.bio = bio
        self.logo = logo
    }
    
    
    
    
}



struct CompanyLogo : Codable{
    
    var url : String
    var thumbnail : String
    var small : String
    var medium : String
    var large : String
    
    init(url: String, thumbnail: String, small: String, medium: String, large: String) {
        self.url = url
        self.thumbnail = thumbnail
        self.small = small
        self.medium = medium
        self.large = large
    }
    
}



