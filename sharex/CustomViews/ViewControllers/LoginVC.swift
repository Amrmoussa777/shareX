//
//  LoginVC.swift
//  sharex
//
//  Created by Amr Moussa on 15/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    static let shared = LoginVC()
    
    let imageView = AvatarImageView()
    let loginLabel = ProductItemLable(textAlignment: .left, NoOfLines: 1, size: 25)
    let emailText = ShareTextFeild(placeHolder: " Email ID ", placeholderImage: Images.emailImage! )
    let passwordText =  ShareTextFeild(placeHolder: " Password", placeholderImage: Images.passwordImage! )
    let loginButton = ShareButton(text: "Login", bGColor: .orange, iconImage: AlertImages.unlockImage)
    let seconderyLabel = ProductItemLable(textAlignment: .center, NoOfLines: 1, size: 15)
    let registerButton = ShareButton(text: "Register", bGColor: .systemBlue, iconImage: AlertImages.registerImage)

    var delegate:loginStatusProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureLoginButton()
        configureRegisterButton()
        // Do any additional setup after loading the view.
    }
    
    
    
    private init(){
        super.init(nibName: nil, bundle: nil)
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func configureLayout(){
        
        view.backgroundColor = .systemBackground
        view.onTapDissmisKeyboard(VC: self)
        
        view.addSubViews(imageView,loginLabel,emailText,
                         passwordText,loginButton,registerButton,seconderyLabel)
        
        imageView.image = Images.loginImage
        imageView.contentMode = .scaleAspectFit
        
        loginLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        loginLabel.setText(text: "Login")
        
        emailText.autocorrectionType = .no
        emailText.autocapitalizationType = .none
        passwordText.isSecureTextEntry = true
        passwordText.autocorrectionType = .no
        
        seconderyLabel.textColor = .lightGray
        seconderyLabel.text = "New to ShareX? Register below"
        
        let padding:CGFloat = 5
        let outterPadding:CGFloat = 20
        let imageViewHeight:CGFloat = DeviceTypes.isSmallSEAndMini ? 180:250
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalToConstant: imageViewHeight),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -10),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outterPadding),
            loginLabel.widthAnchor.constraint(equalToConstant: 150),
            loginLabel.heightAnchor.constraint(equalToConstant: 80),
            
            emailText.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: padding),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outterPadding),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outterPadding),
            emailText.heightAnchor.constraint(equalToConstant: 50),
            
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: padding*2),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outterPadding),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outterPadding),
            passwordText.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: outterPadding),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outterPadding),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outterPadding),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -outterPadding),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outterPadding),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outterPadding),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            seconderyLabel.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -padding),
            seconderyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outterPadding),
            seconderyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outterPadding),
            seconderyLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
        
    }

}


extension LoginVC{
    
    private func configureLoginButton(){
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
    }
    
    @objc func loginTapped(){
        if (emailText.text?.isValidEmail ?? false && passwordText.text?.isValidPassword ?? false){
            let loadingScreen = showLoadingView()
            NetworkManager.Shared.signInUSer(email: emailText.text ?? "", pass: passwordText.text ?? "" ) { isSignedIn in
                loadingScreen.removeFromSuperview()
                switch(isSignedIn){
                
                case false:
                    self.view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "we can not find a match for you email and password in our data base ", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
               
                case true:
                    self.dismiss(animated: true) {
                        self.delegate?.userLoginStatusChanged(ststus: .loggedin)
                        }
                }
            }
         
        }else{
            view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "Please add valid Email and Password", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
        }
    }
    
    
    private func configureRegisterButton(){
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
    }
    
    @objc func registerTapped(){
        
        dismiss(animated: true) { [self] in
            delegate?.userLoginStatusChanged(ststus: .tappedRegisterButton)
        }
       
    }
    
    // keyboard handling
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


protocol  loginStatusProtocol {
    func userLoginStatusChanged(ststus:userLoginStatus)
    
}
