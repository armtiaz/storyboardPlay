//
//  RegisterViewController.swift
//  storyboardPlay
//
//  Created by Arman Imtiaz on 13/3/22.
//

import UIKit


class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private let logoimageview: UIImageView! = {
        let logoimageview = UIImageView()
        logoimageview.image = UIImage(named: "logo")
        logoimageview.contentMode = .scaleAspectFit
        
        //for rounded image on profile image look do this below
        
        logoimageview.layer.masksToBounds = true
        logoimageview.layer.borderWidth = 2
        logoimageview.layer.borderColor = UIColor.lightGray.cgColor
        return logoimageview
    }()
    
    private let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.contentMode = .scaleToFill
       return stackView
    }()
    
    private let firstname :UITextField = {
        let firstname = UITextField()
        firstname.autocorrectionType = .no
        firstname.autocapitalizationType = .none
        firstname.returnKeyType = .continue
        firstname.placeholder = "enter your firstname"
        firstname.borderStyle = .roundedRect
        return firstname
    }()
    private let lastname :UITextField = {
        let lastname = UITextField()
        lastname.autocorrectionType = .no
        lastname.autocapitalizationType = .none
        lastname.returnKeyType = .continue
        lastname.placeholder = "enter your lastname"
        lastname.borderStyle = .roundedRect
        return lastname
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
    
    private let RegisterButton :UIButton = {
       let RegisterButton = UIButton()
        RegisterButton.backgroundColor = .systemGreen
        RegisterButton.setTitle("Register", for: .normal)
        RegisterButton.setTitleColor(.white, for: .normal)
        RegisterButton.layer.cornerRadius = 5
        
        return RegisterButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemGray3
        //title = "log in"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(didTapLoginFromNav))
        
        // add subviews
        
        RegisterButton.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        firstname.delegate = self
        lastname.delegate = self
        emailField.delegate = self
        passField.delegate = self
        
        
        view.addSubview(scrollView  )
        scrollView.addSubview(logoimageview)
        scrollView.addSubview(firstname)
        scrollView.addSubview(lastname)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passField)
        scrollView.addSubview(RegisterButton)
        
        scrollView.isUserInteractionEnabled = true
        logoimageview.isUserInteractionEnabled =  true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfilePic))
        logoimageview.addGestureRecognizer(gesture)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        logoimageview.frame = CGRect(x: (scrollView.width)/3, y: 50, width: size, height: size)
        
        //if you want rounded profile image
        logoimageview.layer.cornerRadius = logoimageview.width/2
        
        firstname.frame = CGRect(x: 30, y: logoimageview.bottom+10, width: scrollView.width-60, height: 52)
        lastname.frame = CGRect(x: 30, y: firstname.bottom+10, width: scrollView.width-60, height: 52)
        emailField.frame = CGRect(x: 30, y: lastname.bottom+10, width: scrollView.width-60, height: 52)
        passField.frame = CGRect(x: 30, y: emailField.bottom+10, width: scrollView.width-60, height: 52)
        RegisterButton.frame = CGRect(x: 30, y: passField.bottom+10, width: scrollView.width-60, height: 52)
    }
    
    @objc func didTapProfilePic()
    {
        //print("profile pic tapped")
        presentPhotoActionSheet()
        
    }
    
    @objc func didTapLoginFromNav(){
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func RegisterButtonTapped(){
        
       // print("here")
        guard let first = firstname.text ,
              let last = lastname.text ,
              let email = emailField.text ,
              let pass = passField.text,
              pass.count>=6,
              !first.isEmpty,
              !last.isEmpty,
              !email.isEmpty,
              !pass.isEmpty
        else {
            alertUserLoginError()
            return
        }
        firstname.resignFirstResponder()
        lastname.resignFirstResponder()
        emailField.resignFirstResponder()
        passField.resignFirstResponder()
        
        print("here i am in registration action button")
        
        //implement the login with database
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "oops!", message: "something went wrong, please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
       
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstname {
            lastname.becomeFirstResponder()
        }
        if textField == lastname {
            emailField.becomeFirstResponder()
        }
        if textField == emailField {
            passField.becomeFirstResponder()
        }
        else if textField == passField{
            RegisterButtonTapped()
        }
        return true
    }
    


}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func presentPhotoActionSheet () {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { [weak self] _ in  self?.presentCamera() }))
        actionSheet.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: { [weak self] _ in self?.presentGallery() }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera()
    {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentGallery() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //print(info)
        
        let  selectedImage = info[UIImagePickerController.InfoKey.editedImage]
        if logoimageview.image != nil {
            self.logoimageview.image = selectedImage as? UIImage
        }
        

    }
}
