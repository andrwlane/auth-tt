//
//  SignInViewModel.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import Combine
import FirebaseAuth
import GoogleSignIn

class SignInViewModel: ObservableObject {
    let authManager: AuthManager
    var emailInput: String = ""
    var passwordInput: String = ""

    @Published var emailValid = true
    @Published var passwordValid = true
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    let emailValidator = EmailValidator()
    let passwordValidator = PasswordValidator()

    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

extension SignInViewModel {
    func onSignInTap() {
        emailValid = emailValidator.validate(emailInput)
        passwordValid = passwordValidator.validate(passwordInput)
        if emailValid && passwordValid {
            isLoading = true
            authManager.signInWith(email: emailInput, password: passwordInput) { [weak self] _, error in
                self?.isLoading = false
                if let error {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func onGoogleAuthTap() {
        isLoading = true
        authManager.googleSignIn { [weak self] result, error in
            self?.isLoading = false
            if let error {
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
