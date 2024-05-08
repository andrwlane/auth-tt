//
//  AuthApp.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
struct AuthApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    @StateObject var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }

    init() {
        setupFirebase()
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

extension AuthApp {
    private func setupFirebase() {
        FirebaseApp.configure()
    }
}
