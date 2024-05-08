//
//  SignUpView.swift
//  Auth
//
//  Created by Andrey Ulanov on 07.05.2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var vm: SignUpViewModel
    @Binding var isPresented: Bool

    var body: some View {
        GeometryReader { reader in
            ScrollView(showsIndicators: false){
                VStack {
                    Spacer()
                    Text("Sign Up")
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Group {
                        TextField("Your Name", text: $vm.nameInput)
                            .grayTextField()
                            .textContentType(.name)
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

                    VStack(spacing: 16) {
                        Button("Sign Up", action: vm.onSignUpTap)
                            .asyncAccentButton(isLoading: vm.isLoading)
                            .disabled(vm.isLoading)
                            .bold()
                            .padding(.top, 16)

                        HStack {
                            Color.gray.opacity(0.2).frame(height: 1)
                            Text("OR")
                            Color.gray.opacity(0.2).frame(height: 1)
                        }
                        HStack {
                            Button(action: {
                                vm.onGoogleAuthTap()
                            }, label: {
                                Image(.googleLogo)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                            })
                            .authProviderButton()
                            .frame(width: 44, height: 44)
                        }
                    }
                    .padding(.bottom, 24)
                }
                .frame(minHeight: reader.size.height)
                .padding(.horizontal, 16)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .padding(14)
                        .foregroundStyle(.primary)
                        .background(
                            Circle()
                                .foregroundStyle(.gray.opacity(0.3))
                        )
                }
                .padding()
            }
            .alert(vm.errorMessage ?? "", isPresented: isErrorPresented()) {
                Button("Ok", role: .cancel, action: {})
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
        SignUpView(vm: .init(
            authManager: .init()), isPresented: .constant(true)
        )
    }
}
