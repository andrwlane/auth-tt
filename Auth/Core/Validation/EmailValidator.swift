//
//  EmailValidator.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import Foundation

struct EmailValidator: InputValidator {
    func validate(_ input: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: input)
    }
}
