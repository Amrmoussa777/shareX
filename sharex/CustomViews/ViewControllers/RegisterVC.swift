//
//  RegisterVC.swift
//  sharex
//
//  Created by Amr Moussa on 15/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    static let shared =  RegisterVC()
    
    let imageView = AvatarImageView()
    let registerLabel = ProductItemLable(textAlignment: .left, NoOfLines: 1, size: 25)
    let registerButton = ShareButton(text: "Next", bGColor: .blue, iconImage: Images.nextButton)
    
    var collectioView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    let pager = UIPageControl()
    
    //Form Components
    //1
    
    let emailFeild = ShareTextFeild(placeHolder: "Email ID", placeholderImage: Images.emailImage!)
    let passwordFeild = ShareTextFeild(placeHolder: "Password", placeholderImage: Images.passwordImage!)
    
    //2
    // image picker
    let imageViewButton  = UIButton()
    let imagePicker     = UIImagePickerController()
    var userImage:UIImage?
    
    let userNameFeild  = ShareTextFeild(placeHolder: "Type your user name ", placeholderImage: Images.userNameImage!)
    
    //3
    let mobileFeild = ShareTextFeild(placeHolder: "Enter valid mobile number", placeholderImage: Images.phoneImage!)
    
    //
    var delegate:loginStatusProtocol?
    
    
    var counter = 0
    let padding:CGFloat = 10
    let outerPadding:CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureImageView()
        configurePager()
        configureImageButtonAction()
        configureRegisterButton()
        
        // Do any additional setup after loading the view.
    }
    
    private init(){
        super.init(nibName: nil, bundle:nil)
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
        view.addSubViews(imageView,registerLabel,registerButton)
        
        registerLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        registerLabel.setText(text: "Sign up")
        
        imagePicker.delegate = self
        
        imageView.image = Images.registerImage
        
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            
            registerLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            registerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: outerPadding),
            registerLabel.widthAnchor.constraint(equalToConstant: 200),
            registerLabel.heightAnchor.constraint(equalToConstant: 80),
            
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -outerPadding),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: outerPadding),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -outerPadding),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    
    private func configureImageView(){
        
        
        layout.scrollDirection = .horizontal
        
        collectioView = UICollectionView(frame:view.bounds , collectionViewLayout: layout)
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.collectionViewLayout = layout
        collectioView.showsHorizontalScrollIndicator = false
        collectioView.showsVerticalScrollIndicator = false
        collectioView.isPagingEnabled = true
        collectioView.isScrollEnabled  = false
        
        
        collectioView.register(ResgisterCollectionViewCell.self, forCellWithReuseIdentifier: ResgisterCollectionViewCell.cellID)
        
        
        
        
        view.addSubview(collectioView)
        collectioView.backgroundColor = .systemBackground
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: outerPadding),
            collectioView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            collectioView.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant: padding),
            collectioView.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -outerPadding),
            
            
        ])
        
        
        
    }
    
    
    private func configurePager(){
        
        view.addSubview(pager)
        pager.pageIndicatorTintColor = .systemGray5
        pager.currentPageIndicatorTintColor = .blue
        
        pager.numberOfPages = 3
        pager.currentPage = 0
        
        pager.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pager.leadingAnchor.constraint(equalTo: collectioView.leadingAnchor),
            pager.trailingAnchor.constraint(equalTo: collectioView.trailingAnchor),
            pager.bottomAnchor.constraint(equalTo: collectioView.bottomAnchor),
            pager.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureImageButtonAction(){
        imageViewButton.addTarget(self, action: #selector(chooseImageFromLibrary), for: .touchUpInside)
    }
    
    @objc func chooseImageFromLibrary(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    private func configureRegisterButton(){
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
    }
    // MARK: - check pages and states
    
    @objc func registerTapped(){
        if counter < 3 {
            //check valid items email  and password
            switch (counter) {
            case 0:
                if (emailFeild.text?.isValidEmail ?? false && ((passwordFeild.originalPassword.isValidPassword))){
                    checkEmailalreadyRegistered(email:emailFeild.text ?? "")
                }else{
                    view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "Please add valid Email and Password", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
                    }
            case 1:
                if userNameFeild.text!.isValidUserName {
                    counter += 1
                    let index = IndexPath.init(item: counter , section: 0)
                    self.collectioView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                }else{
                    view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "Please add a valid User name ...", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
                    
                    }
                
            case 2:
                if mobileFeild.text!.isValidPhoneNumber {
                   registerUserInDB()
                }else{
                    view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "Please add a valid phone number ... ", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
                    }
                
            default:
                print("error")
            }
            
        }
        
        
        if counter == 3-1 {
            // last page customization.
            registerButton.setTitle("Register", for: .normal)
            registerButton.setImage(Images.checkMarkImage, for: .normal)
        }
        
    }
    
    private func checkEmailalreadyRegistered(email:String?){
        guard  let validEmail = email else {return}
        
        NetworkManager.Shared.checkEmailExist(email: validEmail) { [weak self] isExist in
            guard let self = self else{return}
           
            switch(isExist){
            case true:
            // enail  exists in DB
                self.view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "Email already exists in our data base .", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
                          
            case false:
                // enail not exist in DB
                self.counter += 1
                let index = IndexPath.init(item: self.counter , section: 0)
                self.collectioView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
            
        }
        
    }
    
    
    // keyboard handling
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}



extension RegisterVC:UICollectionViewDelegate,
                     UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResgisterCollectionViewCell.cellID, for: indexPath) as! ResgisterCollectionViewCell
        let (views,constrains,message) = getUIViewForCpecificCell(cellindex: indexPath.row, cell: cell)
        cell.tag = indexPath.row
        cell.addContentViews(views, constrains: constrains, topMessage: message)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width , height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        counter = Int(roundedIndex)
        pager.currentPage = Int(roundedIndex)
    }
    
    
}


extension RegisterVC{
    
    private func getUIViewForCpecificCell(cellindex:Int,cell:UICollectionViewCell)->([UIView],[NSLayoutConstraint],message:String){
        var views:[UIView] = []
        var constrains:[NSLayoutConstraint] = []
        
        
        //cell one
        if cellindex == 0 {
            emailFeild.autocorrectionType = .no
            emailFeild.autocapitalizationType = .none
            
            passwordFeild.autocorrectionType = .no
            passwordFeild.autocorrectionType = .no
            passwordFeild.configurePasswordView()
            
            
            
            
            
            let firstCellConstrains = [
                emailFeild.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 100),
                emailFeild.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                emailFeild.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
                emailFeild.heightAnchor.constraint(equalToConstant: 50),
                
                passwordFeild.topAnchor.constraint(equalTo: emailFeild.bottomAnchor,constant: padding*2),
                passwordFeild.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                passwordFeild.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
                passwordFeild.heightAnchor.constraint(equalToConstant: 50)
            ]
            
            views.append(emailFeild)
            views.append(passwordFeild)
            constrains = constrains + firstCellConstrains
            return (views,constrains, """
                    Email  must be an active email adress
                    and password must be a least 8 digits
                    long and can contain A-Z,a-z and numbers.
                """ )
        }
        
        
        //cell two
        else if cellindex == 1 {
            
            let CellConstrains = [
                imageViewButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 50),
                imageViewButton.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                imageViewButton.widthAnchor.constraint(equalToConstant: 100),
                imageViewButton.heightAnchor.constraint(equalToConstant: 100),
                
                userNameFeild.topAnchor.constraint(equalTo: imageViewButton.bottomAnchor,constant: outerPadding),
                userNameFeild.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                userNameFeild.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
                userNameFeild.heightAnchor.constraint(equalToConstant: 50)
            ]
            imageViewButton.translatesAutoresizingMaskIntoConstraints = false
            
            imageViewButton.backgroundColor = .systemGray6
            imageViewButton.setImage(Images.plusImage, for: .normal)
            imageViewButton.roundShape()
            views.append(imageViewButton)
            views.append(userNameFeild)
            constrains = constrains + CellConstrains
            return (views,constrains,"""
                choose a proper photo of you
                and enter user name that would
                apper next to your image in
                    your profile .
                """)
        }
        
        else if cellindex == 2 {
            
            let CellConstrains = [
                
                mobileFeild.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 100),
                mobileFeild.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                mobileFeild.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor,constant: -padding),
                mobileFeild.heightAnchor.constraint(equalToConstant: 50)
            ]
            mobileFeild.keyboardType = .phonePad
            views.append(mobileFeild)
            
            constrains = constrains + CellConstrains
            return (views,constrains,"""
                    phone numbers should be 10-12 digits
                    in length only numbers are accepted "+"
                    symbol in the beginning of the number
                         is still acceptable .
                    """)
        }
        
        return (views,constrains,"Please add vaild infos ... ")
    }
    
    private func registerUserInDB(){
        //user.image = image
        let user = User(id: "", userName:  userNameFeild.text ?? "", userRating: 3,avatarUrl: "",
                        image: userImage, email: emailFeild.text ?? "", phoneNumber: "")
        let loadingScreen = showLoadingView()
        NetworkManager.Shared.registerUserInDB(user: user, WithPAssword: passwordFeild.originalPassword) {[weak self] isSaved in
            loadingScreen.removeFromSuperview()
           
            guard let self = self else{return}
            
            switch(isSaved){
            
            case false:
                self.view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "There is a problem saving your data in our data base ", buttonLabel: "OK", buttonImage: Images.nextButton!,actionButtonColor: .blue)
                self.collectioView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                self.registerButton.setTitle("Next", for: .normal)
           
            case true:
                self.dismiss(animated: true) {
                    self.delegate?.userLoginStatusChanged(ststus: .registered)
                    }
               
                
            }
        }
    }
    

}

extension RegisterVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewButton.contentMode = .scaleAspectFit
            imageViewButton.setImage(pickedImage , for: .normal)
            userImage = pickedImage.compressedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



