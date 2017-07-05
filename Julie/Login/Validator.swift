//
//  Validator.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

class Validator {
    
    static func isValidEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}",
                                             options: .CaseInsensitive)
        return regex.firstMatchInString(email, options:[],
                                        range: NSRange(location: 0, length: email.characters.count)) != nil
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[^-_.+@0-9a-zA-Z]", options: .CaseInsensitive)
        let valid = regex.firstMatchInString(password, options: [],
                                             range: NSRange(location: 0, length: password.characters.count))
        return valid == nil && password.characters.count > 5
    }
    
}
