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
  
    @SceneStorage("selectedView") var selectedView: String?
    
    @State var isAuthenticated = AuthState.IsAuthenticated()
    
    
    var body: some View {
        Group { isAuthenticated ?
                   AnyView(
                    
                    TabView(selection: $selectedView) {
                        HomeView().tabItem {
                                            Label("Home", systemImage: "house")
                                        }.tag(HomeView.tag)
                        
                        
                        MessageView().tabItem{
                            Label("Messages", systemImage: "mail")
                        }.tag(MessageView.tag)
                        ProfileView().tabItem {
                                            Label("Profile", systemImage: "person")
                        }.tag(ProfileView.tag)
                    }

                    
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
