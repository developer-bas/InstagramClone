//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 03/12/20.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
//    MARK: - Properties
    var viewModel : PostViewModel? {
        didSet{ configure() }
    }
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
//    MARK: - Lyfecycle
    override init(frame: CGRect){
        super.init(frame: frame)
    
        backgroundColor = .gray
        
        addSubview(postImageView)
        postImageView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        guard let viewModel = viewModel else {return}
        postImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
