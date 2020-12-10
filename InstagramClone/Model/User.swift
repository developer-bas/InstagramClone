//
//  User.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 04/12/20.
//

import Foundation
import Firebase

struct User {
    
    let email : String
    let uid: String
    let username: String
    let fullname: String
    let profileImageUrl: String
    
    var isFollowed = false
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(dictionary: [String:Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
}
