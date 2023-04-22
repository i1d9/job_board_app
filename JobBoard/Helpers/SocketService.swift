//
//  SocketService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import Foundation



import SocketIO

import Combine



struct MM: Codable{
    
    var payload : [SocketMessage]
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.payload = try container.decode([SocketMessage].self, forKey: .payload)
    }
}

final class SocketService : ObservableObject{
    private var manager = SocketManager(socketURL: URL(string: "ws://127.0.0.1:1337")!, config: [ .compress])
    
    @Published var socket_messages : [SocketMessage] = []
    @Published var room : SocketMessage = SocketMessage(id: 0, room: "", texts: [])
    
    let socket : SocketIOClient
    init(){
        self.socket = manager.defaultSocket
        
        self.socket.on(clientEvent: .connect, callback: {data, ack in
            print("Connected")
        })
        
        self.socket.on("messages") {data, ack in
            
            guard let cur = data[0] as? String else { return }
            let jsonObjectData = cur.data(using: .utf8)!
            

            
            do {
                
                let candidate  =  try JSONDecoder().decode(
                    MM.self,
                    from: jsonObjectData
                )


                self.socket_messages = candidate.payload
                
                
                
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                self.socket_messages = []
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.socket_messages = []
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.socket_messages = []
                
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.socket_messages = []
            } catch let error {
                assertionFailure(error.localizedDescription)
                self.socket_messages = []
            }

            
            
        }
        
        self.socket.on("room_messages") {data, ack in
            
            guard let cur = data[0] as? String else { return }
            let jsonObjectData = cur.data(using: .utf8)!
            
         
            
            do {
                
                let room_details  =  try JSONDecoder().decode(
                    SocketMessage.self,
                    from: jsonObjectData
                )


                self.room = room_details
                
                print(room_details)
                
                
                
                
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                self.room = SocketMessage(id: 0, room: "", texts: [])
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.room = SocketMessage(id: 0, room: "", texts: [])
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.room = SocketMessage(id: 0, room: "", texts: [])
                
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.room = SocketMessage(id: 0, room: "", texts: [])
            } catch let error {
                assertionFailure(error.localizedDescription)
                self.room = SocketMessage(id: 0, room: "", texts: [])
            }

            
            
            
        }
        
        
        
        socket.connect(withPayload: ["token": NetworkService.current_user!.token])
    }
    
    
    func sendMesage(room_name: String, message : String) {
        
        self.socket.emit("send_message", ["room": room_name, "text": message])
    }
    
    
    func joinRoom(room_name: String){
        self.socket.emit("join_room", ["room": room_name])
    }
    
    
    func exitRoom(room_name: String){
        self.socket.emit("exit_room", ["room": room_name])
    }
}


