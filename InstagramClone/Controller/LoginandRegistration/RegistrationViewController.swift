//
//  RegistrationViewController.swift
//  RegistrationViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit
import SafariServices

class RegistrationViewController: UIViewController {
    
    private let userName: UITextField = {
        let userName = UITextField()
        userName.placeholder = "Username"
        userName.autocapitalizationType = .none
        userName.autocorrectionType = .no
        userName.leftViewMode = .always
        userName.returnKeyType = .next
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        userName.layer.masksToBounds = true
        userName.layer.cornerRadius = constants.cornerradius
        userName.backgroundColor = .secondarySystemBackground
        userName.layer.borderWidth = 1.0
        userName.layer.borderColor = UIColor.gray.cgColor
        return userName
    }()
    
    private let EmailField: UITextField = {
        let EmailField = UITextField()
        EmailField.placeholder = "Email"
        EmailField.autocapitalizationType = .none
        EmailField.autocorrectionType = .no
        EmailField.leftViewMode = .always
        EmailField.returnKeyType = .next
        EmailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        EmailField.layer.masksToBounds = true
        EmailField.layer.cornerRadius = constants.cornerradius
        EmailField.backgroundColor = .secondarySystemBackground
        EmailField.layer.borderWidth = 1.0
        EmailField.layer.borderColor = UIColor.gray.cgColor
        return EmailField
    }()
    
    private let PasswordField: UITextField = {
        let PasswordField = UITextField()
        PasswordField.isSecureTextEntry = true
        PasswordField.placeholder = "Password"
        PasswordField.autocapitalizationType = .none
        PasswordField.autocorrectionType = .no
        PasswordField.leftViewMode = .always
        PasswordField.returnKeyType = .done
        PasswordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        PasswordField.layer.masksToBounds = true
        PasswordField.layer.cornerRadius = constants.cornerradius
        PasswordField.backgroundColor = .secondarySystemBackground
        PasswordField.layer.borderWidth = 1.0
        PasswordField.layer.borderColor = UIColor.gray.cgColor
        return PasswordField
    }()
    
    private let createAccountButton: UIButton = {
        let createAccountButton = UIButton()
        createAccountButton.layer.masksToBounds = true
        createAccountButton.layer.cornerRadius = constants.cornerradius
        createAccountButton.setTitle("Sign-Up", for: .normal)
        createAccountButton.backgroundColor = .green
        createAccountButton.setTitleColor(.white, for: .normal)
        return createAccountButton
    }()
    
    private let SignInButton: UIButton = {
        let SignInButton = UIButton()
        SignInButton.layer.masksToBounds = true
        SignInButton.layer.cornerRadius = constants.cornerradius
        SignInButton.setTitle("Already have an account? Sign-In", for: .normal)
       // SignInButton.backgroundColor = .green
        SignInButton.setTitleColor(.gray, for: .normal)
        return SignInButton
    }()
    
    private let termsButton: UIButton = {
        let termsButton = UIButton()
        termsButton.setTitle("Terms", for: .normal)
        termsButton.setTitleColor(.secondaryLabel, for: .normal)
        return termsButton
    }()

    private let privacyPolicyButton: UIButton = {
        let privacyPolicyButton = UIButton()
        privacyPolicyButton.setTitle("Privacy & Policies", for: .normal)
        privacyPolicyButton.setTitleColor(.secondaryLabel, for: .normal)
        return privacyPolicyButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Create Account"
        userName.delegate = self
        EmailField.delegate = self
        PasswordField.delegate = self
        addSubViews()
        createAccountButton.addTarget(self, action: #selector(tapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(tapTermsButton), for: .touchUpInside)
        privacyPolicyButton.addTarget(self, action: #selector(tapPrivacyPolicyButton), for: .touchUpInside)
        SignInButton.addTarget(self, action: #selector(tapSignInButton), for: .touchUpInside)
    }
    
    private func addSubViews(){
        view.addSubview(userName)
        view.addSubview(EmailField)
        view.addSubview(PasswordField)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyPolicyButton)
        view.addSubview(SignInButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userName.frame = CGRect(x: 25, y: view.safeAreaInsets.top + 15, width: view.width - 50, height: 40)
        EmailField.frame = CGRect(x: 25, y: userName.bottom + 15, width: view.width - 50, height: 40)
        PasswordField.frame = CGRect(x: 25, y: EmailField.bottom + 15, width: view.width - 50, height: 40)
        createAccountButton.frame = CGRect(x: 25, y: PasswordField.bottom + 15, width: view.width - 50, height: 50)
        SignInButton.frame = CGRect(x: 25, y: createAccountButton.bottom + 15, width: view.width - 50, height: 50)
        termsButton.frame = CGRect(x: 30, y: view.height - view.safeAreaInsets.bottom - 50, width: (view.width - 15) / 2, height: 50)
        privacyPolicyButton.frame = CGRect(x: termsButton.width - 30, y: view.height - view.safeAreaInsets.bottom - 50, width: (view.width - 15) / 2, height: 50)
    }

    @objc func tapCreateAccountButton(){
        guard let username = userName.text, !username.isEmpty,
                let email = EmailField.text, !email.isEmpty,
                let password = PasswordField.text, !password.isEmpty, password.count >= 8 else {
                    return
                }
        //Register User
        
        AuthManager.shared.registerNewUser(email: email, username: username, password: password) { inserted in
            if inserted{
                
            }else {
                //not able to insert data
            }
        }
    }
    
    @objc func tapSignInButton(){
        
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: {
               self.navigationController!.popToRootViewController(animated: true)
            })
        }
        else {
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    @objc func tapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
     }
    
    @objc func tapPrivacyPolicyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
     }
}

extension RegistrationViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userName{
            EmailField.becomeFirstResponder()
        } else if textField == EmailField {
            PasswordField.becomeFirstResponder()
        }else if textField == PasswordField{
            tapCreateAccountButton()
        }
        
        return true
    }
}
