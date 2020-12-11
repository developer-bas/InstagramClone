//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 05/12/20.
//

import UIKit

struct ProfileHeaderViewModel {
    
    let user : User
    
    var fullname: String{
         return user.fullname
    }
    
    var profileImageUrl : URL? {
        return URL(string: user.profileImageUrl)
    }
    var followButtontext: String {
       if user.isCurrentUser{
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor{
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStackText(value: user.stats.followers, label: "Followers")
    }
    
    var numberOfFollowing: NSAttributedString{
        return attributedStackText(value: user.stats.following, label: "Following")
    }
    
    var numberOfPosts : NSAttributedString {
        return attributedStackText(value: 4, label: "Post")
    }
    
    init(user:User) {
        self.user = user
    }
    
    
    func attributedStackText(value: Int, label: String)-> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
}
