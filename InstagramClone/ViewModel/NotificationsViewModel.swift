//
//  NotificationsViewModel.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 04/01/21.
//

import Foundation

struct NotificationsViewModel {
    private let notification: Notification
    
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "")}
    
    var profileImageUrl : URL? { return URL(string: notification.userProfileImageUrl )}
    

}
