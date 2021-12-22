//
//  LoginVM.swift
//  login
//
//  Created by Binay Kumar Sharma on 22/12/21.
//

import SwiftUI
import Combine

class LoginVM:ObservableObject{
    @Published var username = "TheEdvorian"
    @Published var password = ""
    @Published var email = ""
    
    @Published var showPassword:Bool = false
    @Published var showingAlert = false
    @Published var showingAlertMsg = ""
    
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var usernameError  = ""
     
    init(){
        
    }
    func isFormValid(){
        checkPasswordError()
        checkUsernameError()
        checkEmailError()
        
        if emailError.isEmpty && passwordError.isEmpty && usernameError.isEmpty {
            showingAlertMsg = "Form is Valid"
        }else{
            showingAlertMsg = "Form is not Valid"
        }
        showingAlert = true
    }
    func checkUsernameError( ){
        usernameError = ""
        if username.isEmpty {
            usernameError  += "Is Empty\n"
        }
        
        if username.contains(" ") {
            usernameError  += "Should not have spaces\n"
        }
        
        if matches(for: "[A-Z]", in: username).count > 0
        {
            usernameError  += "no upper case alphabet"
        }
    }
    
    func checkPasswordError(){
        //should have 8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet
        passwordError = ""
        if password.isEmpty {
            passwordError  += "Is Empty\n"
        }
        
        if password.count < 7{
            passwordError += "should have 8 characters\n"
        }
       
        if matches(for: "[0-9]", in: password).count ==  0 {
            passwordError += "should have 1 number\n"
        }
       
        if matches(for: "[A-Z]", in: password).count == 0{
            passwordError += "should have 1 upper case alphabet\n"
        }
        
        if matches(for: "[a-z]", in: password).count == 0{
            passwordError += "should have 1 lower case alphabet"
        }
        
    }
    
    func checkEmailError(){
        emailError = ""
        if email.isEmpty {
            emailError  += "Is Empty\n"
        }
        
        let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegEx = name + "@" + domain + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if !emailPredicate.evaluate(with: email){
            emailError += "must be a valid email"
        }
        
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
     
     
}
