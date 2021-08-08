//
//  ProfileVC.swift
//  sharex
//
//  Created by Amr Moussa on 04/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    let contentView = UIView()
    let header = ProfileHeader()
    let infoView = ProfileInfoView()
    var parentVC:UIViewController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureDissmis()
        NetworkManager.Shared.currentRootVC = self
   
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NetworkManager.Shared.currentRootVC = parent
    
    
    }
    


    
    private func configureLayout(){
       

        view.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        view.addSubview(contentView)
         
        let viewHeight = view.frame.size.height
        let padding:CGFloat = 10
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor,constant: viewHeight/2),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        
        contentView.addSubViews(header,infoView)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: contentView.topAnchor),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: padding),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
            header.heightAnchor.constraint(equalToConstant: 150),
            
            infoView.topAnchor.constraint(equalTo: header.bottomAnchor,constant: padding),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        
        
        
    }
    
    
    func getUser(){
        NetworkManager.Shared.getCurrentUserInfo {[weak self] user in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.header.setData(user: user)
                self.getCountAndOrders()
            }
            
        }
        
       
        contentView.layer.cornerRadius = 10
    }
    func getCountAndOrders(){
        NetworkManager.Shared.getProductForCurrentUser {[weak self] produts in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.infoView.setDate(favCount: produts.count, orderCount: produts.count)
            }
            
        }
    }
    

}

extension ProfileVC:UIGestureRecognizerDelegate{
    
    private func configureDissmis(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisVC))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    //AVoid dissmissing view gtom content view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}



class CurentUserProfile:ProfileVC{
  
    
    
    let logOutButton = LogOutButton(text: "Log Out ", bGColor: .orange, iconImage: Images.logOut)
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        configureAsCurrentProfile()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func configureAsCurrentProfile(){
//        logOutButton.backgroundColor = .clear
        view.addSubview(logOutButton)
        let padding:CGFloat = 10
        let  safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    @objc func logOutTapped(){
        NetworkManager.Shared.logOutUser {[weak self] loggedOut in
            guard let self = self else {return}
            switch(loggedOut){
            case true:
                self.dismiss(animated: true) {
                    NetworkManager.Shared.currentRootVC = self.parentVC
                    NetworkManager.Shared.restoreAppDefaultState()
                    
                }
            case false:
                self.view.showAlertView(Message: "There was a problem logging out,try again", buttonLabel: "Ok")
            }
        }
        
      
    }
    
    
    
    
}
