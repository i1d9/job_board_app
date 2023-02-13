//
//  MessageView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI
import SocketIO


struct MessageView: View {
    
    
    
    
    @StateObject var service = SocketService()
    
    
    static let tag: String? = "MessageView"
   
    var body: some View {
        NavigationView{
            
            
            List(){
                ForEach(service.socket_messages){message in
                    NavigationLink(destination: MessageDetailView(

                        socketMessage: message,
                    
                        socket: service
                    )) {
                        Text(message.receiver)
                    }
                }
              
            }.navigationTitle("My Messages")
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
