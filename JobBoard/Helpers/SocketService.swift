//
//  SocketService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import Foundation



import SocketIO



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
    
    let socket : SocketIOClient
    init(){
        self.socket = manager.defaultSocket
        
        self.socket.on(clientEvent: .connect, callback: {data, ack in
            
            
            print("Connected")
        })
        
        
        self.socket.on("messages") {data, ack in
            
            
            guard let cur = data[0] as? String else { return }
            let jsonObjectData = cur.data(using: .utf8)!

            // Decode the json data to a Candidate struct
            let candidate = try? JSONDecoder().decode(
                MM.self,
                from: jsonObjectData
            )
            
            
            self.socket_messages = candidate!.payload
            
            

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


