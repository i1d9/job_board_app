//
//  MessageDetailView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 10/02/2023.
//

import SwiftUI

struct MessageDetailView: View {
    
    @State var socketMessage : SocketMessage
    @State private var message : String = ""
    
    
    @State var socket : SocketService
    var body: some View {
        
        ZStack(alignment: .bottom){
            ScrollView{
                
                HStack(alignment: .center){
                 
                    Text("Application Accepted").padding(4).background(.green).foregroundColor(.white)
                 
                }
                VStack(alignment: .trailing){
                    
                    
                    ForEach(socket.room.texts, id:
                                \.id){text in
                        
                        if(text.source == NetworkService.current_user?.id && text.source != 0 ){
                            
                            MyMessageView(text: text.text)
                        }else if (text.source != 0){
                            TheirMessage(text: text.text)
                            
                        }
                        
                    }
                    
                }.navigationTitle(socketMessage.receiver).onAppear{
                    print(NetworkService.current_user!.id)
                }
            }
            
            
            HStack {
                TextField("Enter your message", text: $message).textFieldStyle(.roundedBorder)
                
                Image(systemName: "paperplane").onTapGesture {
                    
                    socket.sendMesage(room_name: socketMessage.room, message: message)
                    message = ""
                }.foregroundColor(.blue)
               
            }.padding(16)
        }.onAppear{
            socket.joinRoom(room_name: socketMessage.room)

        }.onDisappear{
            socket.exitRoom(room_name: socketMessage.room)
        }
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MessageDetailView(
        
            socketMessage: SocketMessage(id: 0, room: "", texts: []), socket: SocketService())
    }
}

struct MyMessageView: View {
    
    var text : String
    var body: some View {
        HStack{
            Spacer()
            
            Text(text).foregroundColor(.white).padding(10).background(.blue).cornerRadius(8)
            
            
        }.padding(10)
    }
}

struct TheirMessage: View {
    var text : String
    var body: some View {
        HStack{
            
            Text(text).foregroundColor(.white).padding(10).background(.green).cornerRadius(8)
            Spacer()
            
        }.padding(10)
    }
}
