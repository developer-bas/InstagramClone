//
//  NotificationCell.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 03/01/21.
//

import UIKit

class NotificationCell : UITableViewCell {
    //    MARK: - Properties
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.text = "Name kajsnnd"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleFollowTapped))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    
    //    MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 12)
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 8)
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor,paddingRight: 12)
        followButton.setHeight(32)
        followButton.setWidth(100)
        
        addSubview(postImageView)
        postImageView.centerY(inView: self)
        
        postImageView.anchor(right: rightAnchor, paddingRight: 12, width: 64 ,height: 64)
        postImageView.setDimensions(height: 40, width: 40  )
        
        followButton.isHidden = true
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleFollowTapped(){
        
    }
    @objc func handlePostTapped(){
        
    }
}
