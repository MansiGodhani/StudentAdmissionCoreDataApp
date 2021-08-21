	//
//  AdminVC.swift
//  StudentAdmissionCoreDataApp
//
//  Created by DCS on 21/08/21.
//  Copyright © 2021 DCS. All rights reserved.
//


    import UIKit
    class AdminVC: UIViewController {
        
        private let usernameTextField:UITextField = {
            let textfield = UITextField()
            textfield.placeholder = "Username"
            textfield.textAlignment = .center
            textfield.borderStyle = .roundedRect
            //textfield.backgroundColor = .systemFill
            return textfield
        }()
        
        private let passwordTextField:UITextField = {
            let textfield = UITextField()
            textfield.placeholder = "Password"
            textfield.textAlignment = .center
            textfield.borderStyle = .roundedRect
            //textfield.backgroundColor = .systemFill
            textfield.isSecureTextEntry = true
            return textfield
        }()
        
        private let mybutton:UIButton = {
            let button = UIButton()
            button.setTitle("Login", for: .normal)
            button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
            button.backgroundColor = .blue
            button.layer.cornerRadius = 6
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            return button
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            
            view.addSubview(usernameTextField)
            view.addSubview(passwordTextField)
            view.addSubview(mybutton)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            let vw=view.frame.width
            usernameTextField.frame = CGRect(x: 40, y: 200, width:vw-80, height: 60)
            passwordTextField.frame = CGRect(x: 40, y: 290, width: vw - 80, height: 60)
            mybutton.frame = CGRect(x: 40, y: 400, width: vw - 80, height: 60)
            
        }
        let username = "Admin"
        let password = "admin"
        
        @objc private func loginTapped()
        {
            if username == usernameTextField.text! && password == passwordTextField.text! {
                UserDefaults.standard.set(usernameTextField.text!, forKey: "email")
                let vc = RDstudVC()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "Alert!", message: "Email and Password didn't match", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
        }
    }
