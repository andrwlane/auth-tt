//
//  ButtonStyles.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import SwiftUI

struct AccentButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                Color.accentButtonBG
                    .opacity(
                        colorScheme == .dark && configuration.isPressed 
                        ? 0.7 : 1
                    )
            )
            .foregroundStyle(.accentButtonTitle
                .opacity(configuration.isPressed ? 0.7 : 1)
            )
            .tint(.accentButtonTitle
                .opacity(configuration.isPressed ? 0.7 : 1)
            )
            .clipShape(.rect(cornerRadius: 6))
    }
}

struct AsyncAccentButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    let isLoading: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 16) {
            configuration.label
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Color.accentButtonBG
                .opacity(
                    colorScheme == .dark && configuration.isPressed
                    ? 0.7 : 1
                )
        )
        .foregroundStyle(.accentButtonTitle
            .opacity(configuration.isPressed ? 0.7 : 1)
        )
        .tint(.accentButtonTitle
            .opacity(configuration.isPressed ? 0.7 : 1)
        )
        .clipShape(.rect(cornerRadius: 6))
        .opacity(isLoading ? 0.8 : 1)
    }
}

struct AuthProviderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundStyle(Color.gray.opacity(0.1))

            configuration.label
                .padding(10)
        }
    }
}

extension Button {
    func accentButton() -> some View {
        self
            .buttonStyle(AccentButtonStyle())
    }

    func asyncAccentButton(isLoading: Bool) -> some View {
        self
            .buttonStyle(AsyncAccentButtonStyle(isLoading: isLoading))
    }

    func authProviderButton() -> some View {
        self
            .buttonStyle(AuthProviderButtonStyle())
    }
}
