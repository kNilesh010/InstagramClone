//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Nilesh Kumar on 10/02/22.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let userNameorEmailField: UITextField = {
        let userNameorEmailField = UITextField()
        userNameorEmailField.placeholder = "Email or Username"
        userNameorEmailField.autocapitalizationType = .none
        userNameorEmailField.autocorrectionType = .no
        userNameorEmailField.leftViewMode = .always
        userNameorEmailField.returnKeyType = .next
        userNameorEmailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        userNameorEmailField.layer.masksToBounds = true
        userNameorEmailField.layer.cornerRadius = constants.cornerradius
        userNameorEmailField.backgroundColor = .secondarySystemBackground
        userNameorEmailField.layer.borderWidth = 1.0
        userNameorEmailField.layer.borderColor = UIColor.gray.cgColor
        return userNameorEmailField
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
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = constants.cornerradius
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .green
        loginButton.setTitleColor(.white, for: .normal)
        return loginButton
    }()
    
    private let createAccountButton: UIButton = {
        let createAccountButton = UIButton()
        createAccountButton.layer.masksToBounds = true
        createAccountButton.layer.cornerRadius = constants.cornerradius
        createAccountButton.setTitle("Don't have an account? Create an Account", for: .normal)
        //createAccountButton.backgroundColor = .green
        createAccountButton.setTitleColor(.systemBlue, for: .normal)
        return createAccountButton
    }()
    
    private let topView: UIView = {
        let topView = UIView()
        topView.clipsToBounds = true
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        logoImage.contentMode = .scaleAspectFill
        topView.addSubview(logoImage)
        return topView
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
        userNameorEmailField.delegate = self
        PasswordField.delegate = self

        view.backgroundColor = .systemBackground
        
        addSubViews()
        
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(tapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(tapTermsButton), for: .touchUpInside)
        privacyPolicyButton.addTarget(self, action: #selector(tapPrivacyPolicyButton), for: .touchUpInside)
    }
    
    private func addSubViews(){
        view.addSubview(userNameorEmailField)
        view.addSubview(PasswordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(topView)
        view.addSubview(termsButton)
        view.addSubview(privacyPolicyButton)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height / 3)
        configureTopView()
        
        userNameorEmailField.frame = CGRect(x: 25, y: topView.bottom + 15, width: view.width - 50, height: 40)
        PasswordField.frame = CGRect(x: 25, y: userNameorEmailField.bottom + 15, width: view.width - 50, height: 40)
        loginButton.frame = CGRect(x: 25, y: PasswordField.bottom + 15, width: view.width - 50, height: 50)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 15, width: view.width - 50, height: 50)
        termsButton.frame = CGRect(x: 30, y: view.height - view.safeAreaInsets.bottom - 50, width: (view.width - 15) / 2, height: 50)
        privacyPolicyButton.frame = CGRect(x: termsButton.width - 30, y: view.height - view.safeAreaInsets.bottom - 50, width: (view.width - 15) / 2, height: 50)
    }
    
    func configureTopView(){
        guard topView.subviews.count == 1 else {return}
        
        guard var backgroundView = topView.subviews.first else {return}
        
        backgroundView.frame = topView.bounds
        
        let imageView = UIImageView(image: UIImage(named: "logotex"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: topView.width, height: topView.height - view.safeAreaInsets.top)
        topView.addSubview(imageView)
        
        
    }
    
   @objc func tapLoginButton(){
       userNameorEmailField.resignFirstResponder()
       PasswordField.resignFirstResponder()
       
       guard let userNameEmail = userNameorEmailField.text, !userNameEmail.isEmpty, let password = PasswordField.text, !password.isEmpty, password.count >= 8
       else {return}
       
       //login
       var email: String?
       var userNameTemp: String?
       
       if userNameEmail.contains("@") && userNameEmail.contains("."){
           email = userNameEmail
       }else {
           userNameTemp = userNameEmail
       }
       
       AuthManager.shared.loginUsers(email: email, userName: userNameTemp, password: password) {success in
           
           DispatchQueue.main.async {
               if success {
                   //logged-in successfully
                   self.dismiss(animated: true, completion: nil)
               }else{
                   //login error
                   let loginAlert = UIAlertController(title: "Login failure", message: "There is an error while trying to login", preferredStyle: .alert)
                   loginAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                   self.present(loginAlert, animated: true, completion: nil)
               }
           }
         
       }
       
    }
    
    @objc func tapCreateAccountButton(){
        let CAB = UINavigationController(rootViewController: RegistrationViewController())
        CAB.title = "Create Account"
        present(CAB, animated: true)
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


extension LoginViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameorEmailField{
            PasswordField.becomeFirstResponder()
        } else if textField == PasswordField {
            tapLoginButton()
        }
        
        return true
    }
}
