//
//  CommentInputAccesoryView.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 21/12/20.
//

import UIKit

class CommentInputAccesoryView: UIView {
    
//    MARK: - Properties
    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeHolderText = "Enter comment"
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        tv.placeholderShouldCenter = true
        return tv
    }()
    private let postButton : UIButton = {
        let buttton = UIButton(type: .system)
        buttton.setTitle("Post", for: .normal)
        buttton.setTitleColor(.black, for: .normal)
        buttton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        buttton.addTarget(self, action: #selector(handleCommentUpload), for: .touchUpInside)
        return buttton
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        addSubview(commentTextView)
        commentTextView.anchor(top:topAnchor,left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor,right: postButton.leftAnchor, paddingTop: 8,paddingBottom: 8, paddingLeft: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        divider.setHeight(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
//    MARK: - Actions
     @objc func handleCommentUpload(){
        
     }
}
