//
//  LoginViewController.swift
//  storyboardPlay
//
//  Created by Arman Imtiaz on 13/3/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let logoimageview: UIImageView! = {
        let logoimageview = UIImageView()
        logoimageview.image = UIImage(named: "logo")
        logoimageview.contentMode = .scaleAspectFit
        return logoimageview
    }()
    
    private let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailField :UITextField = {
        let emailField = UITextField()
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.returnKeyType = .continue
        emailField.placeholder = "enter your email"
        emailField.borderStyle = .roundedRect
        return emailField
    }()
    
    private let passField :UITextField = {
       let passField = UITextField()
        passField.returnKeyType = .done
        passField.autocapitalizationType = .none
        passField.autocorrectionType = .no
        passField.placeholder = "enter your password"
        passField.borderStyle = .roundedRect
        passField.isSecureTextEntry = true
        return passField
    }()
    
    private let loginButton :UIButton = {
       let loginButton = UIButton()
        loginButton.backgroundColor = .link
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        return loginButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemGray3
        //title = "log in"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "register", style: .done, target: self, action: #selector(didtapregister))
        
        // add subviews
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        emailField.delegate = self
        passField.delegate = self
        
        view.addSubview(scrollView  )
        scrollView.addSubview(logoimageview)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passField)
        scrollView.addSubview(loginButton)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        logoimageview.frame = CGRect(x: (scrollView.width)/3, y: 50, width: size, height: size)
        emailField.frame = CGRect(x: 30, y: logoimageview.bottom+10, width: scrollView.width-60, height: 52)
        passField.frame = CGRect(x: 30, y: emailField.bottom+10, width: scrollView.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passField.bottom+10, width: scrollView.width-60, height: 52)
    }
    
    @objc func didtapregister(){
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func loginButtonTapped(){
        
       // print("here")
        guard let email = emailField.text , let pass = passField.text,pass.count>=6, !email.isEmpty, !pass.isEmpty else { alertUserLoginError()
            return
        }
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
        print("here i am in login")
        
        //implement the login with database
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "oops!", message: "something went wrong, please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
       
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passField.becomeFirstResponder()
        }
        else if textField == passField{
            loginButtonTapped()
        }
        return true
    }
    


}
