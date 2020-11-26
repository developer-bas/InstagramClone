//
//  FeedCell.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 25/11/20.
//

import UIKit

class FeedCell : UICollectionViewCell{

//    MARK: - Properties
    
    private let profileImageView : UIImageView  = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "venom-7")
        return image
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapName), for: .touchUpInside)
        return  button
    }()
    
    private let postImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "venom-7")
        return image
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
  
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "1 like"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "some text"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
//    MARK: - Lifecycle

    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12,paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Actions
    @objc func didTapName(){
        
    }
}
