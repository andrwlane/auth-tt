//
//  ClosableModal.swift
//  Auth
//
//  Created by Andrey Ulanov on 08.05.2024.
//

import SwiftUI

struct ClosableModal: ViewModifier {
    @Binding var isPresented: Bool
    func body(content: Content) -> some View {
        content
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
    }
}

extension View {
    func closableModal(isPresented: Binding<Bool>) -> some View {
        modifier(ClosableModal(isPresented: isPresented))
    }
}
