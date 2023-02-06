//
//  SocketService.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 06/02/2023.
//

import Foundation



import SocketIO



class SocketParser {

    static func convert<T: Decodable>(data: Any) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonData)
    }

    static func convert<T: Decodable>(datas: [Any]) throws -> [T] {
        return try datas.map { (dict) -> T in
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData)
        }
    }

}

class SocketChatManager {

    // MARK: - Properties
    let manager = SocketManager(socketURL: URL(string: "http://localhost:1337")!, config: [.log(false), .compress])
    var socket: SocketIOClient? = nil

    // MARK: - Life Cycle

    init() {
        setupSocket()
        setupSocketEvents()
        socket?.connect()
    }

    func stop() {
        socket?.removeAllHandlers()
    }

    // MARK: - Socket Setup

    func setupSocket() {
        self.socket = manager.defaultSocket
    }

    func setupSocketEvents() {
        socket?.on(clientEvent: .connect) {data, ack in
            print("Connected")
        }
        
        socket?.on("login") { (data, ack) in
            
        }
        
        
        
    }
    


    func register(user: String) {
        socket?.emit("add user", user)
    }



}
