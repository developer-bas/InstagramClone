//
//  NotificationsViewModel.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 04/01/21.
//

import Foundation
import UIKit

struct NotificationsViewModel {
     let notification: Notification
    
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "")}
    
    var profileImageUrl : URL? { return URL(string: notification.userProfileImageUrl )}
    
    var notificationMessage : NSAttributedString{
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font : UIFont.boldSystemFont(ofSize: 15)])
        
        attributedText.append(NSAttributedString(string: "  \(message)", attributes: [.font : UIFont.systemFont(ofSize: 13)]))
        
        attributedText.append(NSAttributedString(string: " 2m", attributes: [.font : UIFont.boldSystemFont(ofSize: 13),.foregroundColor:UIColor.lightGray]))
        
        return attributedText
    }
    
    
    var shouldHidePostImage: Bool {return self.notification.type == .follow}
    
//    var shouldHideFollowButton: Bool {return notification.type != .follow }
    
}
