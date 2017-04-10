//
//  LoginController.swift
//  Messenger
//
//  Created by Adam Bezák on 10.4.17.
//  Copyright © 2017 Adam Bezák. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    let inputsContainterView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user: FIRUser?, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let values = ["names": name, "email": email]
            
            let ref = FIRDatabase.database().reference(fromURL: "https://messenger-e3c8c.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    return
                }
                
                print("Saved")
            })

            
        })
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pic")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b:151)
        
        view.addSubview(inputsContainterView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImage)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        
    }
    func setupProfileImageView() {
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: inputsContainterView.topAnchor, constant: -12).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupInputsContainerView() {
        inputsContainterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainterView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainterView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainterView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainterView.addSubview(nameTextField)
        inputsContainterView.addSubview(nameSeparatorView)
        inputsContainterView.addSubview(emailTextField)
        inputsContainterView.addSubview(emailSeparatorView)
        inputsContainterView.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainterView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainterView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainterView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainterView.heightAnchor, multiplier: 1/3).isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainterView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainterView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainterView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainterView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainterView.heightAnchor, multiplier: 1/3).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainterView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainterView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainterView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainterView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainterView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainterView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainterView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1.0)
    }
}
