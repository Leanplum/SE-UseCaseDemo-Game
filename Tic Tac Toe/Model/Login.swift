//
//  Login.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 2/27/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//


import UIKit
import os.log


class Login: NSObject, NSCoding {
    
    //properties
    var userLogin: String!
    var email: String!
    
    //Mark: Archiving Paths
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("login")

    //types
    struct PropertyKey {
        static let userLogin = "userLogin"
        static let email = "email"
    }
    
    //initialization
    init?(userLogin: String, email: String){
        
        //should fail if empty value
        guard !userLogin.isEmpty || !email.isEmpty else {
            return nil
        }
        
        //init stored properties
        self.userLogin = userLogin
        self.email = email
    }
    
    //NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userLogin, forKey: PropertyKey.userLogin)
        aCoder.encode(email, forKey: PropertyKey.email)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        //name is required. If we cannont decode a name string, the init should fail
        guard let userLogin = (aDecoder.decodeObject(forKey: PropertyKey.userLogin) as? String)
            else {
                os_log("Unable to decode User Name", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let email = (aDecoder.decodeObject(forKey: PropertyKey.email) as? String)
            else {
                os_log("Unable to decode Email", log: OSLog.default, type: .debug)
                return nil
        }
        
        //call the designated init
        self.init(userLogin: userLogin, email: email)
    }
}
