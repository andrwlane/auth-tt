//
//  SignUpViewModel.swift
//  Auth
//
//  Created by Andrey Ulanov on 07.05.2024.
//

import Combine
import FirebaseAuth
import GoogleSignIn

class SignUpViewModel: ObservableObject {
    let authManager: AuthManager
    var nameInput: String = ""
    var emailInput: String = ""
    var passwordInput: String = ""

    @Published var emailValid = true
    @Published var passwordValid = true
    @Published var nameValid = true
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    let emailValidator = EmailValidator()
    let passwordValidator = PasswordValidator()
    let nameValidator = NameValidator()

    init(authManager: AuthManager) {
        self.authManager = authManager
    }
}

extension SignUpViewModel {
    func onSignUpTap() {
        emailValid = emailValidator.validate(emailInput)
        passwordValid = passwordValidator.validate(passwordInput)
        nameValid = nameValidator.validate(nameInput)
        if emailValid && passwordValid && nameValid {
            isLoading = true
            authManager.signUpWith(
                email: emailInput,
                password: passwordInput,
                displayName: nameInput) { [weak self] _, error in
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
