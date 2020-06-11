

import Foundation
import UIKit

class ValidationClass: NSObject {
    
    func blankValidationOnCheckoutForm(_ obj : ViewController) -> Bool {
        obj.view.endEditing(true)
        if isBlank(obj.nameField) {
            obj.view.makeToast(message: "Enter name.")
            return false
        }else if isBlank(obj.emailField) {
            obj.view.makeToast(message: "Enter email.")
            return false
        }else if isValidEmail(obj.emailField.text!) {
            obj.view.makeToast(message: "Enter valid email.")
            return false
        }else if isBlank(obj.phoneNumberField){
            obj.view.makeToast(message: "Enter phone number.")
            return false
        }else if isValidPhoneNumber(obj.phoneNumberField.text!){
            obj.view.makeToast(message: "Enter valid phone number.")
            return false
        }else if isBlank(obj.amountField){
            obj.view.makeToast(message: "Enter amount.")
            return false
        }else if isTextViewBlank(obj.shippingAddressTextView){
            obj.view.makeToast(message: "Enter shipping address.")
            return false
        }else if isBlank(obj.shippingStateField){
            obj.view.makeToast(message: "Enter shipping state.")
            return false
        }else if isBlank(obj.shippingCityField){
            obj.view.makeToast(message: "Enter shipping city.")
            return false
        }else if isTextViewBlank(obj.billingAddressTextView){
            obj.view.makeToast(message: "Enter billing address.")
            return false
        }else if isBlank(obj.billingStateField){
            obj.view.makeToast(message: "Enter billing state.")
            return false
        }else if isBlank(obj.shippingCityField){
            obj.view.makeToast(message: "Enter billing city.")
            return false
        }else {
            return true
        }
    }
    
    
    func isTextViewBlank(_ textview:UITextView) -> Bool {
        
        if textview.text.isEmpty || textview.text == "Address*"{
            return true
        }
        return false
    }
    
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    func isValidEmail(_ EmailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = EmailStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidPhoneNumber(_ PhoneStr:String) -> Bool {
        
        let phoneRegEx = "[0-9]{10}"
        let range = PhoneStr.range(of: phoneRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return !result
    }
}
