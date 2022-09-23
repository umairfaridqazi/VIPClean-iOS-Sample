//
//  Defaults.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

class Defaults {
    
    // MARK: registration
    static let jazzcashnameprefix = "JazCash";
    
    static var FirstName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "firstName")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: jazzcashnameprefix + "firstName") ?? ""
        }
    }
    
    
   
    static var LastName: String {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "lastName")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: jazzcashnameprefix + "lastName") ?? ""
        }
    }
    
    
    static var Language: String {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "Language")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: jazzcashnameprefix + "Language") ?? ""
        }
    }
    
   
    
    static var Mobile: String {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "mobile")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: jazzcashnameprefix + "mobile") ?? ""
        }
    }
    
    
   
    
    static var DeviceId: String {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "deviceId")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: jazzcashnameprefix + "deviceId") ?? ""
        }
    }
    
   
    static var token: String {
        set{
            print("token not set yet")
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "token")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: jazzcashnameprefix + "token") ?? ""
        }
    }
    
    
    static var isUserLoggedin: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "isUserLogged")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: jazzcashnameprefix + "isUserLogged")
        }
    }
    
   static var isUserGuest: Bool {
       set{
           UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "isUserGuest")
           UserDefaults.standard.synchronize()
       }
       get{
           return UserDefaults.standard.bool(forKey: jazzcashnameprefix + "isUserGuest")
       }
   }
    
    static var firstTimeUser: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: jazzcashnameprefix + "firstTimeUser")
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: jazzcashnameprefix + "firstTimeUser")
        }
    }
    
    
    
}

