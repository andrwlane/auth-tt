//
//  InputValidator.swift
//  Auth
//
//  Created by Andrey Ulanov on 06.05.2024.
//

import Foundation

protocol InputValidator {
    associatedtype InputType
    func validate(_ input: InputType) -> Bool
}
