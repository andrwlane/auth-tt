//
//  ContentView.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject var reachability = NetworkReachabilty.shared

    var body: some View {
        if reachability.isNetworkConnected {
            Group {
                if authManager.currentUser != nil,
                    authManager.authOperationsCompleted {
                    WelcomeView(vm: WelcomeViewModel(
                        authManager: authManager
                    ))
                } else {
                    NavigationStack {
                        SignInView(vm: SignInViewModel(
                            authManager: authManager
                        ))
                    }
                }
            }
            .environmentObject(authManager)
        } else {
            VStack(spacing: 24) {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                Text("Network not available")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
}
