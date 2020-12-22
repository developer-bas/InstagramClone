//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 11/12/20.
//


import UIKit

protocol UploadPostControllerDelegate: class {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
//   MARK: - Properties
    weak var delegate: UploadPostControllerDelegate?
    var currentUser : User? 
    
    var selectedImage : UIImage? {
        didSet{ photoImageView.image = selectedImage}
    }
    
   private  let photoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
    
        return iv
    }()
    
    private lazy var captionTextView : InputTextView = {
        let tv = InputTextView()
        tv.placeHolderText = "Enter caption ..."
        tv.backgroundColor = .blue
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.placeholderShouldCenter = false
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
        
        print("DEBUG ESTOY EN DID")
        guard let image = selectedImage else {return}
        guard let caption = captionTextView.text else {return}
        guard let user = currentUser else {return}
        
        showLoader(true)
        
        PostService.uploadPost(caption: caption, user: user, image: image) { error in
            
            self.showLoader(false)
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
        
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
