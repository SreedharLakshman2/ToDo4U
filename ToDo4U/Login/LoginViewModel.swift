//
//  LoginViewModel.swift
//  ToDo4U
//
//  Created by IFOCUS on 1/31/23.
//

import Foundation

class LoginViewModel {
    var loginUserName: String = "sample@gmail.com"
    var loginPassword: String = "sample@123"
    var isValidEmail: Bool = false
    var isValidPassword: Bool = false
    var enableLoginButton: Bool = false
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "^(?!\\.)([A-Z0-9a-z_%+-]?[\\.]?[A-Z0-9a-z_%+-])+@[A-Za-z0-9-]{1,20}(\\.[A-Za-z0-9]{1,15}){0,10}\\.[A-Za-z]{2,20}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
   }
}
