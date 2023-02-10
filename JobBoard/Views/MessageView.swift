//
//  MessageView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI

struct MessageView: View {
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
