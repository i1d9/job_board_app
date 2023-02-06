//
//  Job.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


struct Job : Codable{
    var name : String
    var description : String
    var company : Company
    var type : String //Contract/Long Term/Short Term/Internship/Consultancy
    var environment : String //Remote/Semi-remote/In-Office
    var status : String
    
}
