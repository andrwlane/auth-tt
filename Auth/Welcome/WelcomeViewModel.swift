//
//  WelcomeViewModel.swift
//  Auth
//
//  Created by Andrey Ulanov on 08.05.2024.
//

import Foundation
import FirebaseAuth

class WelcomeViewModel: ObservableObject {
    private let authManager: AuthManager
    @Published var emailSent = false
    @Published var checkingForVerification = false
    @Published var deletingUser = false

    var userDisplayName: String {
        authManager.currentUser?.displayName ?? "User"
    }

    var userEmailVerified: Bool {
        authManager.currentUser?.isEmailVerified ?? false
    }

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func onSignOutTapped() {
        authManager.signOut()
    }

    func onVerifyEmailTapped() {
        authManager.currentUser?.sendEmailVerification()
        emailSent = true
    }

    func onVerificationCompletedTapped() {
        checkVerification()
    }

    func onDeleteAccountTapped() {
        deletingUser = true
        authManager.deleteUserAccount()
    }

    func onRefresh() async {
        try? await authManager.reloadUser()
    }

    private func checkVerification() {
        Task {
            checkingForVerification = true
            try? await authManager.reloadUser()
            checkingForVerification = false
        }
    }
}
