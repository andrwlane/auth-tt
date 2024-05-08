//
//  NameValidator.swift
//  Auth
//
//  Created by Andrey Ulanov on 07.05.2024.
//

import Foundation

struct NameValidator: InputValidator {
    func validate(_ input: String) -> Bool {
        input.count >= 2
    }
}
