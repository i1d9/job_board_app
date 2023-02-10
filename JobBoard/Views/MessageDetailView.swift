//
//  MessageDetailView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 10/02/2023.
//

import SwiftUI

struct MessageDetailView: View {
    var body: some View {
        
        ScrollView{
            VStack(alignment: .trailing){
                
                MyMessageView()
                
                
                TheirMessage()
                
                
            }.navigationTitle("Username")
        }.toolbar{
            ToolbarItem{
                Text("Call")
            }
        }
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MessageDetailView()
    }
}

struct MyMessageView: View {
    var body: some View {
        HStack{
            Spacer()
            
            Text("Heyyy").foregroundColor(.white).padding(10).background(.green).cornerRadius(8)
            
            
        }.padding(10)
    }
}

struct TheirMessage: View {
    var body: some View {
        HStack{
            
            Text("Heyyy").foregroundColor(.white).padding(10).background(.green).cornerRadius(8)
            Spacer()
            
        }.padding(10)
    }
}
