//
//  NetworkService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


class NetworkService {
    static var current_user : User? = nil
    
    func login(identifier : String, password:String, completion: @escaping (User?) -> ()){
        
    }
    
    
    func register(first_name:String, last_name: String, username: String,email:String, phone:String, completion: @escaping (User?) -> ()  ){
        
    }
    
    
    func loadProfile(){
        
    }
    
    func loadApplications(){
        
    }
    
    
    func listCompanies(){
        
    }
    
    func viewApplication(id: Int){
        
    }
    
    func listJobs(){
        
    }
    
    func applyJob(introduction_letter: String, cirriculum_vitae: String){
        
    }
    
    
    
    func myApplications(){
        
    }
    
    
}
