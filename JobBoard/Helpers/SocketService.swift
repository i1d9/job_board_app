//
//  SocketService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import Foundation



import SocketIO


final class SocketService : ObservableObject{
    private var manager = SocketManager(socketURL: URL(string: "ws://127.0.0.1:1337")!, config: [.log(true), .compress])
    
    init(){
        let socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect, callback: {data, ack in
            
            
            print("Connected")
        })
        
        socket.connect()
    }
}


