//
//  ContentView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI
import SocketIO

final class Tst : ObservableObject{
    private var manager = SocketManager(socketURL: URL(string: "ws://127.0.0.1:1337")!, config: [.log(true), .compress])
    
    init(){
        let socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect, callback: {data, ack in
            
            
            print("Connected")
        })
        
        socket.connect()
    }
}
struct ContentView: View {
    
    
    @ObservedObject var service =  Tst()
  
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding().onAppear{

      
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
