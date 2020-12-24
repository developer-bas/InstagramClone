//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 23/12/20.
//

import Foundation
import UIKit

class CommentViewModel  {
    private let comment : Comment
    
    var profileImageUrl: URL?{
        return URL(string: comment.profileImageUrl)
    }
    
    
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func commentLabelText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(comment.username)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 12)]))
        
        return attributedString
    }
}
