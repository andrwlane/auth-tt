//
//  SignInView.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import SwiftUI

struct SignInView: View {
    @StateObject var vm: SignInViewModel
    @State private var isSignUpPresented = false
    @State private var isPasswordResetPresented = false

    var body: some View {
        GeometryReader { reader in
            ScrollView(showsIndicators: false){
                VStack {
                    Spacer()
                    Text("Sign In")
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Group {
                        TextField("Email", text: $vm.emailInput)
                            .grayTextField(isWrong: !vm.emailValid)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                        SecureField("Password", text: $vm.passwordInput)
                            .grayTextField(isWrong: !vm.passwordValid)
                            .textContentType(.password)
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                    VStack(spacing: 12) {
                        Button("Sign In", action: vm.onSignInTap)
                            .asyncAccentButton(isLoading: vm.isLoading)
                            .disabled(vm.isLoading)
                            .bold()
                            .padding(.top, 16)
                        HStack {
                            Color.gray.opacity(0.2).frame(height: 1)
                            
                            Button(action: {
                                vm.onGoogleAuthTap()
                            }, label: {
                                Image(.googleLogo)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                            })
                            .authProviderButton()
                            .frame(width: 44, height: 44)

                            Color.gray.opacity(0.2).frame(height: 1)
                        }
                    }

                    VStack(spacing: 0) {
                        Group {
                            Button("Forgot password? **Reset**") { 
                                isPasswordResetPresented = true
                            }
                            Button("Not signed up yet? **Sign Up**") {
                                isSignUpPresented = true
                            }
                        }
                        .foregroundStyle(.gray)
                        .frame(height: 44)
                    }
                }
                .frame(minHeight: reader.size.height)
                .padding(.horizontal, 16)
                .fullScreenCover(isPresented: $isSignUpPresented) {
                    let vm = SignUpViewModel(authManager: vm.authManager)
                    SignUpView(vm: vm, isPresented: $isSignUpPresented)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .fullScreenCover(isPresented: $isPasswordResetPresented) {
                    let vm = PasswordResetViewModel(authManager: vm.authManager)
                    PasswordResetView(vm: vm)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .closableModal(isPresented: $isPasswordResetPresented)
                }
                .alert(vm.errorMessage ?? "", isPresented: isErrorPresented()) {
                    Button("Ok", role: .cancel, action: {})
                }
            }
        }
    }

    func isErrorPresented() -> Binding<Bool> {
        .init {
            vm.errorMessage != nil
        } set: { value in
            vm.errorMessage = nil
        }
    }
}

#Preview {
    NavigationStack {
        SignInView(vm: .init(
            authManager: .init())
        )
    }
}
