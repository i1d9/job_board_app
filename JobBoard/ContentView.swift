//
//  ContentView.swift
//  JobBoard
//
//  Created by Ian Nalyanya on 05/02/2023.
//

import SwiftUI
import SocketIO


struct ContentView: View {
    
    
    @ObservedObject var service =  SocketService()
    private var network = NetworkService()
  
    @State var isAuthenticated = AuthState.IsAuthenticated()
    var body: some View {
        Group { isAuthenticated ?
                   AnyView(HomeView()
                   ) :
                                             AnyView(LoginView())
                       }.onReceive(AuthState.Authenticated, perform: {
                   isAuthenticated = $0
                           
                          
               })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
