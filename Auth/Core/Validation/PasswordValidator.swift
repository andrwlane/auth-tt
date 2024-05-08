//
//  PasswordValidator.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import Foundation

struct PasswordValidator: InputValidator {
    func validate(_ input: String) -> Bool {
        input.count >= 6
    }
}
