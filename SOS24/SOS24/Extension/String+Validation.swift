//
//  String+Validation.swift
//  SOS24
//
//  Created by Valentyn Khimchuk on 19.04.2021.
//

import Foundation

extension String {
    
    func validatePhoneNumber() -> Bool {
        self.range(of: "(0(?=.*[0-9])).{9}", options: .regularExpression) != nil
    }
}

extension Optional where Wrapped == String {
    
    func validatePhoneNumber() -> Bool {
        self?.validatePhoneNumber() ?? false
    }
}
