//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 11/12/20.
//

import Foundation
import UIKit

class UploadPostController: UIViewController {
    
//   MARK: - Properties
   private  let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
    iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var captionTextView : InputTextView = {
        let tv = InputTextView()
        tv.placeHolderText = "Enter caption ..."
        tv.backgroundColor = .blue
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv
    }()
    
    private let characterCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
//   MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
//    MARK: - Actions
    @objc func didTapCancel(){
        
    }
    @objc func didTapDone(){
        
    }
//   MARK: - Helpers
    
    func checkMaxLengh(_ textView: UITextView){
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        
        
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 8
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor,  paddingTop: 16, paddingLeft: 12, paddingRight: 12, width: 64, height: 64)
        
        captionTextView.setDimensions(height: 64, width: view.frame.width - 15)
        
        view.addSubview(characterCounterLabel)
        characterCounterLabel.anchor(top: captionTextView.bottomAnchor,right: view.rightAnchor, paddingBottom: -10, paddingRight: 12)
    }
    
}

extension UploadPostController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLengh(textView)
        let count = textView.text.count
        characterCounterLabel.text = "\(count)/100"
        
        captionTextView.placeHolderLabel.isHidden = !captionTextView.text.isEmpty
    }
}
