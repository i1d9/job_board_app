//
//  NetworkService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import Foundation
import PhotosUI


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
                         
                         
                             KeychainHelper.standard.save(loaded_user.user, service: "strapi_job_authentication_service",
                                                          account: "strapi_job_app")
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
    
    
    func my_profile(completion: @escaping (User) -> ()){
        
        guard  let url = URL(string: "\(api_url)/users/me?populate=profile&populate=role")  else {
            
            completion(NetworkService.current_user!)
            fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        
        
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(NetworkService.current_user!.token)", forHTTPHeaderField: "Authorization")
        
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                   if let error = error {
                       print("Request error: ", error)
                       completion(NetworkService.current_user!)
                       return
                   }
                   // ensure there is data returned
                   guard let responseData = data else {
                       print("nil Data received from the server")
                       completion(NetworkService.current_user!)
                       return
                   }
                   do {
                       
                       
                       let profile_response = try JSONDecoder().decode(MyProfileResponse.self, from: responseData)
                       
                           KeychainHelper.standard.save(profile_response.user, service: "strapi_job_authentication_service",
                                                        account: "strapi_job_app")
                   
                       NetworkService.current_user = profile_response.user
                      
                       completion(profile_response.user)
                   } catch let error {
                       print(error.localizedDescription)
                       completion(NetworkService.current_user!)

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
                    "phone_number": phone
                
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
                          
                              KeychainHelper.standard.save(loaded_user.user, service: "strapi_job_authentication_service",
                                                           account: "strapi_job_app")
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
    
    func loadApplications(completion: @escaping ([JobApplication]) -> ()){
        
        guard let url = URL(string: "\(api_url)/groceries?populate=image") else {
            completion([])
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(NetworkService.current_user!.token)", forHTTPHeaderField: "Authorization")
    }
    
    
    func listCompanies(completion: @escaping ([Company])-> ()){
        
        guard let url = URL(string: "\(api_url)/groceries?populate=image") else {
            completion([])
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(NetworkService.current_user!.token)", forHTTPHeaderField: "Authorization")
    }
    
    func viewApplication(id: Int){
        
    }
    
    func listJobs(completion: @escaping ([Job]) -> ()){
        
        guard let url = URL(string: "\(api_url)/jobs?populate=company") else {
            completion([])
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(NetworkService.current_user!.token)", forHTTPHeaderField: "Authorization")
        
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    completion([])
                    return
                }
                // ensure there is data returned
                guard let responseData = data else {
                    print("nil Data received from the server")
                    completion([])
                    return
                }
                do {
                    
                    let loaded_items = try JSONDecoder().decode(BulkJobServerResponse.self, from: responseData)
                   
                    completion(loaded_items.data)
                } catch let error {
                    print(error.localizedDescription)
                    completion([])

                }
            }
            
            dataTask.resume()
    }
    
    func applyJob(introduction_letter: String, cirriculum_vitae: String){
        
    }
    
    
    
    func myApplications(){
        
        
    }
    
    
    private func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }

    public typealias Parameters = [String: Any]

    private func createProfileImageDataBody(withParameters params: Parameters?, media: [UploadImage]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }
    
    func updateProfile(selectedImageData: Data?, username: String, first_name: String, last_name:String,email:String, phone_number:String, completion: @escaping(User) -> ()){
        
        
        guard let url = URL(string: "\(authentication_url)/local/profile") else {
            completion(NetworkService.current_user!)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(NetworkService.current_user!.token)", forHTTPHeaderField: "Authorization")
        //create boundary
          let boundary = generateBoundary()
          //set content type
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let mediaImage = UploadImage(withImage: UIImage(data: selectedImageData!)!, forKey: "profile") else { return }
        
        let parameters: [String: Any] = [
            "username": username,
            "email" : email,
            "first_name": first_name,
            "last_name": last_name,
            "phone_number": phone_number
        
        ]
        
        let dataBody = createProfileImageDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        
        urlRequest.httpBody = dataBody
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data else {
                assertionFailure("nil Data received from the server")
                completion(NetworkService.current_user!)
                return
            }
            do {
                let loaded_user  = try JSONDecoder().decode(MyProfileResponse.self, from: responseData)
                
                    KeychainHelper.standard.save(loaded_user.user, service: "strapi_job_authentication_service",
                                                 account: "strapi_job_app")
                NetworkService.current_user = loaded_user.user
                completion(loaded_user.user)
            } catch {
               print(error)
            }
           }
           
        dataTask.resume()
    }
    
    
    func updateProfile(username: String, first_name: String, last_name:String,email:String, phone_number:String, completion: @escaping(User) -> ()){
        
        guard let url = URL(string: "\(authentication_url)/local/profile") else {
            completion(NetworkService.current_user!)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(NetworkService.current_user!.token)", forHTTPHeaderField: "Authorization")
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "username": username,
            "email" : email,
            "first_name": first_name,
            "last_name": last_name,
            "phone_number": phone_number
        
        ]
    
        do {
           // convert parameters to Data and assign dictionary to httpBody of request
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            print(urlRequest)
         } catch let error {
           assertionFailure(error.localizedDescription)
             completion(NetworkService.current_user!)
             return
         }
        
        
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
               if let error = error {
                   print("Request error: ", error)
                   completion(NetworkService.current_user!)
                   return
               }
            // ensure there is data returned
              guard let responseData = data else {
                  assertionFailure("nil Data received from the server")
                  completion(NetworkService.current_user!)
                  return
              }
              do {
                  
                  let loaded_user  = try JSONDecoder().decode(MyProfileResponse.self, from: responseData)
                  
                      KeychainHelper.standard.save(loaded_user.user, service: "strapi_job_authentication_service",
                                                   account: "strapi_job_app")
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
                  completion(NetworkService.current_user!)
              }
           }
           dataTask.resume()
        
    }
    
    
}
