//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 03/12/20.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
//    MARK: - Properties
    
//    MARK: - Lyfecycle
    override init(frame: CGRect){
        super.init(frame: frame)
    
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
