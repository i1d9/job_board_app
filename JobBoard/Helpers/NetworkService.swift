//
//  NetworkService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation


class NetworkService {
    private var base_url : String
       private var api_url : String
       private var authentication_url : String
       static var current_user : User?
       init() {
           
           self.base_url = "http://localhost:1337"
           self.api_url = "\(base_url)/api"
           self.authentication_url = "\(api_url)/auth"
           
       }
    
    func login(identifier : String, password:String, completion: @escaping (User?) -> ()){
        guard  let url = URL(string: "\(authentication_url)/local/")  else {
                    completion(nil)
                    fatalError("Missing URL")
                    
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let parameters: [String: Any] = [
                    "identifier": identifier,
                    "password": password ]
                
                do {
                   // convert parameters to Data and assign dictionary to httpBody of request
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                    print(urlRequest)
                 } catch let error {
                   assertionFailure(error.localizedDescription)
                     completion(nil)
                   return
                 }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                      if let error = error {
                          print("Request error: ", error)
                          completion(nil)
                          return
                      }
                   // ensure there is data returned
                     guard let responseData = data else {
                         assertionFailure("nil Data received from the server")
                         completion(nil)
                       return
                     }
                     do {
                         
                         let loaded_user  = try JSONDecoder().decode(AuthenticationResponse.self, from: responseData)
                         NetworkService.current_user = loaded_user.user
                         completion(loaded_user.user)
                         
                     } catch let DecodingError.dataCorrupted(context) {
                         print(context)
                     } catch let DecodingError.keyNotFound(key, context) {
                         print("Key '\(key)' not found:", context.debugDescription)
                         print("codingPath:", context.codingPath)
                     } catch let DecodingError.valueNotFound(value, context) {
                         print("Value '\(value)' not found:", context.debugDescription)
                         print("codingPath:", context.codingPath)
                     } catch let DecodingError.typeMismatch(type, context)  {
                         print("Type '\(type)' mismatch:", context.debugDescription)
                         print("codingPath:", context.codingPath)
                     } catch let error {
                         assertionFailure(error.localizedDescription)
                         completion(nil)
                     }
                  }
                  dataTask.resume()
    }
    
    
    func register(first_name:String, last_name: String, username: String,email:String, phone:String, password: String, completion: @escaping (User?) -> ()  ){
        
                guard  let url = URL(string: "\(authentication_url)/local/register")  else {
                    
                    completion(nil)
                    fatalError("Missing URL") }

                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let parameters: [String: Any] = [
                    "username": username,
                    "password": password,
                    "email" : email,
                    "first_name": first_name,
                    "last_name": last_name,
                    "phone": phone
                
                ]
            
                do {
                   // convert parameters to Data and assign dictionary to httpBody of request
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                    print(urlRequest)
                 } catch let error {
                   assertionFailure(error.localizedDescription)
                     completion(nil)
                   return
                 }
                
                let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                       if let error = error {
                           print("Request error: ", error)
                           completion(nil)
                           return
                       }
                    // ensure there is data returned
                      guard let responseData = data else {
                          assertionFailure("nil Data received from the server")
                          completion(nil)
                        return
                      }
                      do {
                          
                          let loaded_user  = try JSONDecoder().decode(AuthenticationResponse.self, from: responseData)
                          KeychainHelper.standard.save(loaded_user.user, service: "grocery_service", account: "grocery_delivery_app")
                          NetworkService.current_user = loaded_user.user
                          completion(loaded_user.user)
                          
                      } catch let DecodingError.dataCorrupted(context) {
                          print(context)
                      } catch let DecodingError.keyNotFound(key, context) {
                          print("Key '\(key)' not found:", context.debugDescription)
                          print("codingPath:", context.codingPath)
                      } catch let DecodingError.valueNotFound(value, context) {
                          print("Value '\(value)' not found:", context.debugDescription)
                          print("codingPath:", context.codingPath)
                      } catch let DecodingError.typeMismatch(type, context)  {
                          print("Type '\(type)' mismatch:", context.debugDescription)
                          print("codingPath:", context.codingPath)
                      } catch let error {
                          assertionFailure(error.localizedDescription)
                          completion(nil)
                      }
                   }
                   dataTask.resume()
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
