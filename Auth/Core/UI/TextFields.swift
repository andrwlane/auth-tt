//
//  TextFields.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import SwiftUI

struct GrayTextField: ViewModifier {
    let isWrong: Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(
                        isWrong ?
                        Color.red.opacity(0.15) :
                        Color.gray.opacity(0.2)
                    )
            )
            .clipShape(.rect(cornerRadius: 6))
    }
}

extension TextField {
    func grayTextField(isWrong: Bool = false) -> some View {
        self.modifier(GrayTextField(isWrong: isWrong))
    }
}

extension SecureField {
    func grayTextField(isWrong: Bool = false) -> some View {
        self.modifier(GrayTextField(isWrong: isWrong))
    }
}

#Preview {
    TextField("Test", text: .constant("Test"))
        .grayTextField(isWrong: true)
}
