//
//  Message.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct Message: Codable{
    
    var from : User
    var to : User
    var text : String
    
}
