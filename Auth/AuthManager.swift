//
//  AuthManager.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import Foundation
import Combine
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var currentUser: User?
    @Published var authOperationsCompleted = true

    init() {
        currentUser = Auth.auth().currentUser
        Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            self?.currentUser = user
        })
    }

    func reloadUser() async throws {
        try await Auth.auth().currentUser?.reload()
        currentUser = Auth.auth().currentUser
    }

    func sendPasswordResetEmail(_ email: String, completion: ((Error?) -> Void)?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }

    func deleteUserAccount(completion: ((Error?) -> Void)? = nil) {
        Auth.auth().currentUser?.delete(completion: completion)
    }

    func signOut() {
        try? Auth.auth().signOut()
    }

    func signUpWith(email: String, password: String, displayName: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        authOperationsCompleted = false
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(nil, error)
                self?.authOperationsCompleted = true
            }

            let request = result?.user.createProfileChangeRequest()
            request?.displayName = displayName
            request?.commitChanges { _ in
                self?.authOperationsCompleted = true
            }
        }
    }

    func signInWith(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(result, error)
        }
    }

    func signInWith(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            completion(result, error)
        }
    }

    func googleSignIn(completion: @escaping (AuthDataResult?, Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                completion(nil, error)
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                completion(result, error)
            }
        }
    }
}
