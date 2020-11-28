//
//  LoginController.swift
//  InstagramClone
//
//  Created by PROGRAMAR on 26/11/20.
//

import UIKit

class LoginController: UIViewController{
    
//    MARK: -Properties
    private let iconImage : UIImageView = {
        let iv =  UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let forgotPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTittle(fistPart: "Forgot your password?", secondPart: "Get help signing in")
        return button
        
    }()
    
    private let donHaveAccountbutton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTittle(fistPart: "Don't  have an account?  ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
        
    }()
    
//    MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
//    MARK: - Actions
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
//    MARK: - Helpers
    func configureUI(){
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
       
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,paddingRight: 32)
    
    
        view.addSubview(donHaveAccountbutton)
        donHaveAccountbutton.centerX(inView: view)
        donHaveAccountbutton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
}