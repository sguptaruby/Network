//
//  URLConstants.swift
//  app
//
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2017 Sagar.Gupta. All rights reserved.
//

import UIKit

internal final class URLConstants: NSObject {
    // Do not allow instantiation of the class
    private override init() {}
    
    /// Base URL
    private class var baseURL: String {
        
        return "http://ucash.hiteshi.com/api/v1"
    }
    
    /// image base url
     class var imageBaseURL: String {
        
        return "http://ucash.hiteshi.com/assets/"
    }
    
    /// User login
    class var login: String {
        return baseURL + "/authentication/login"
    }
    
    /// Forgot password
    class var forgotpassword: String {
        return baseURL + "/ForgotPassword/forgotlink"
    }
    
    /// Logout password
    class var logout: String {
        return baseURL + "/Logout/merchantlogout"
    }
    
    /// profile
    class var profile: String {
        return baseURL + "/MerchantDetails/merchantProfile"
    }
    
    /// edit profile
    class var editprofile: String {
        return baseURL + "/MerchantDetails/merchantEditProfile"
    }

    /// change password
    class var changepassword: String {
        return baseURL + "/ChangePassword/setNewPassword"
    }
    
    /// show bank details
    class var bankdetail: String {
        return baseURL + "/BankDetails/show"
    }
    
    /// update bank details
    class var updatebankdetail: String {
        return baseURL + "/BankDetails/update"
    }
    
    /// faq
    class var faq: String {
        return baseURL + "/faq/faqlist"
    }
    
    /// get history
    class var history: String {
        return baseURL + "/TransactionHistoryList/showlist"
    }
}
