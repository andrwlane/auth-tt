//
//  PasswordResetViewModel.swift
//  Auth
//
//  Created by Andrey Ulanov on 08.05.2024.
//

import Foundation
import FirebaseAuth

class PasswordResetViewModel: ObservableObject {
    private let authManager: AuthManager
    @Published var emailInput: String = ""
    @Published var emailValid: Bool = true
    @Published var isLoading = false
    @Published var isEmailSent = false
    @Published var errorMessage: String? = nil

    let emailValidator = EmailValidator()

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func onNextTapped() {
        emailValid = emailValidator.validate(emailInput)
        if emailValid {
            isLoading = true
            authManager.sendPasswordResetEmail(emailInput) { [weak self] error in
                self?.isLoading = false

                if let error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.isEmailSent = true
                }
            }
        }
    }
}
