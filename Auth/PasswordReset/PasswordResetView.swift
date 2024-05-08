//
//  PasswordResetView.swift
//  Auth
//
//  Created by Andrey Ulanov on 07.05.2024.
//

import SwiftUI

struct PasswordResetView: View {
    @StateObject var vm: PasswordResetViewModel

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                Group {
                    if vm.isEmailSent {
                        Text("Email has been sent")
                            .font(.system(size: 32, weight: .bold))
                    } else if let errorMessage = vm.errorMessage {
                        VStack {
                            Text("Error")
                                .font(.system(size: 32, weight: .bold))
                            Text(errorMessage)
                                .font(.footnote)
                        }
                    } else {
                        VStack(spacing: 16) {
                            Spacer()

                            Text("What is your email? 📭")
                                .font(.system(size: 32, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)

                            TextField("Email", text: $vm.emailInput)
                                .grayTextField(isWrong: !vm.emailValid)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)

                            Button("Next") {
                                vm.onNextTapped()
                            }
                            .asyncAccentButton(isLoading: vm.isLoading)
                            .padding(.bottom, 24)
                        }
                    }
                }
                .frame(minHeight: reader.size.height)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    PasswordResetView(vm: .init(authManager: .init()))
}
