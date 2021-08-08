//
//  SharesView.swift
//  sharex
//
//  Created by Amr Moussa on 08/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit




class SharesView: UIView{
    
    
    //create share view and then pass Set() no of shares .[Strings] of inUsers ids
    //collection view of shares
    
    let label = ProductPriceLabel()
    var collectionView:UICollectionView!
    let layout  = UICollectionViewFlowLayout()
    let padding:CGFloat = 10
    
    let joinButton = ShareButton(text: "Join Now", bGColor: .orange, iconImage: Images.bagImage)
    
    var users:[User] = []
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        configureJoinButton()
        configureCollectionView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel(){
        
        label.text = "Shares"
        label.backgroundColor = .systemGray5
        label.textColor = .orange
        label.textAlignment = .center
        label.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        addSubview(label)
        label.anchorWithPadding(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 60))
        
        
    }

    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout:layout)
        
        collectionView.delegate  = self
        collectionView.dataSource  = self
        collectionView.register(ShareCell.self, forCellWithReuseIdentifier: ShareCell.cellID)
        
        addSubview(collectionView)
        //WARN
        collectionView.anchorWithPadding(top: label.bottomAnchor, leading: leadingAnchor, bottom: joinButton.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize(width: 0, height: 0))
        collectionView.backgroundColor = .systemBackground
        AddStroke(color: .systemGray5)
    }
    
    func configureJoinButton(){
        addSubview(joinButton)
        
        joinButton.anchorWithPadding(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding), size: CGSize(width: 0, height: 50))
        
        
    }
    
    
    func setUsers(users:[String]){
        var usersArr:[User] = []
        for user in  users{
            
        NetworkManager.Shared.getUserInfo(userID: user) {[weak self] user in
            guard let  self = self else {return}
                usersArr.append(user)
                self.users  = usersArr
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
                
            }
        }
       
        
       
    }
    
    func changeJoinButtonState(enabled:Bool,label:String){
        joinButton.isEnabled = enabled
        joinButton.backgroundColor = .blue
        joinButton.setTitle(label, for: .normal)
        joinButton.setImage(Images.checkMarkImage, for: .normal)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
            
            AddStroke(color: .systemGray5)
           }
       }
    }

}



extension SharesView: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShareCell.cellID, for: indexPath) as! ShareCell
        cell.setUser(user: users[indexPath.row])
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
                
        return CGSize(width: collectionViewSize, height: 60)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
