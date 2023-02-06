//
//  Company.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct Company : Codable{
    
    var name : String
    var phone : String
    var email : String
    var address : String
    var category : String //Tech/Pharma/Transport/NGO/Finance
}



struct CompanyLogo : Codable{
    
    var thumbnail : String
    var small : String
    var medium : String
    var large : String
}
