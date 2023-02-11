//
//  MessageView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI
import SocketIO


struct MessageView: View {
    
    @ObservedObject var service =  SocketService()
    static let tag: String? = "MessageView"
    var body: some View {
        NavigationView{
            
            
            List{
                NavigationLink(destination: MessageDetailView()) {
                    Text("Messages")
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
