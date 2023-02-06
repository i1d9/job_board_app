//
//  Application.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct JobApplication: Codable {
    
    
    var applicant : User
    var job : Job
    var cv_url: String
    var status : String
    
    
}
