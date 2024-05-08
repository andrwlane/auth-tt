//
//  WelcomeView.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import SwiftUI
import FirebaseAuth

struct WelcomeView: View {
    @StateObject var vm: WelcomeViewModel

    init(vm: WelcomeViewModel) {
        self._vm = .init(wrappedValue: vm)
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Hello, \(vm.userDisplayName)!")
                    .font(.headline)

                Button("Sign Out") {
                    vm.onSignOutTapped()
                }
                .accentButton()

                if !(vm.userEmailVerified) {
                    if !vm.emailSent {
                        Button("Verify your email") {
                            vm.onVerifyEmailTapped()
                        }
                        .accentButton()
                    } else {
                        VStack {
                            Text("Go to inbox and verify your email, then tap button below")
                            Button("Verified") {
                                vm.onVerificationCompletedTapped()
                            }
                            .asyncAccentButton(isLoading: vm.checkingForVerification)
                        }
                    }
                }

                Button("Delete account") {
                    vm.onDeleteAccountTapped()
                }
                .asyncAccentButton(isLoading: vm.deletingUser)
                .foregroundStyle(.red)
                .tint(.red)
            }
            .padding(.horizontal, 16)
        }
        .refreshable {
            await vm.onRefresh()
        }
    }

}
