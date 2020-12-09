//
//  UserCellViewModel.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 08/12/20.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl : URL?{
        return URL(string: user.profileImageUrl)
    }
    
    var username : String{
        return user.username
    }
    
    var fullname : String {
        return user.fullname
    }
    
    init(user:User) {
        self.user = user
    }
}
