//
//  DetailedProductVCViewController.swift
//  sharex
//
//  Created by Amr Moussa on 08/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class DetailedProductVC: UIViewController {
    
    
    let scrollView       = UIScrollView()
    let scrollContentView = UIView()
    
    let userHeader       = CellHeader()
    let InfoView         = CommunityCellInfoView()
    let sharesView       = SharesView()
    let footerArea       = DestailedProductFooterView()
    
    let commentTextAndSend = TypeAndSendArea()
    let commentView = CommentVeiw()

    
    var product:CommProduct!
    
    let padding:CGFloat = 5
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configureContentView()
        configureSharesView()
        configureFooter()
        configureJoinButton()
        configureCommentButton()
        
        configureComemnrtArea()
        configureFavButton()
        loadData(updatedProduct: product)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
    }
    
    

    private func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.pinToSuperViewSafeArea(in: view)
        scrollView.backgroundColor = .systemBackground
        view.onTapDissmisKeyboard(VC: self)
    }
    
    private func configureContentView(){
        scrollView.addSubview(scrollContentView)
        scrollContentView.pinToSuperViewEdges(in: scrollView)
        
        NSLayoutConstraint.activate([
            scrollContentView.heightAnchor.constraint(equalToConstant: 1000),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        configureHeader()
        configureInfoView()
        
    }
    
    private func configureHeader(){
        scrollContentView.addSubViews(userHeader)
        // create
        userHeader.anchorWithPadding(top: scrollContentView.topAnchor, leading: scrollContentView.leadingAnchor, bottom: nil, trailing: scrollContentView.trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize( width: 0, height: 70))
    }
    
    private func configureInfoView(){
        scrollContentView.addSubViews(InfoView)

        
        // create
        InfoView.anchorWithPadding(top: userHeader.bottomAnchor, leading: scrollContentView.leadingAnchor, bottom: nil, trailing: scrollContentView.trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize( width: 0, height: 50))
        
    }
    
    private func configureSharesView(){
        scrollContentView.addSubview(sharesView)
        sharesView.anchorWithPadding(top: InfoView.bottomAnchor, leading: scrollContentView.leadingAnchor, bottom: nil, trailing: scrollContentView.trailingAnchor, padding: UIEdgeInsets(top: padding*2, left: padding, bottom: padding, right: padding), size:  CGSize( width: 0, height: 300))
        sharesView.RoundCorners()
  
        
    }
    
    private func configureFooter(){
        scrollContentView.addSubview(footerArea)
        
        footerArea.anchorWithPadding(top: sharesView.bottomAnchor, leading:scrollContentView.leadingAnchor, bottom: nil, trailing: scrollContentView.trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize(width: 0, height: 60))
        
        
        
    }
    
    
    private func configureComemnrtArea(){
        scrollContentView.addSubViews(commentTextAndSend,commentView)
        
        commentView.product = product
        commentView.loadComments()
        commentView.configureCommentButton(commentButton: footerArea.commentButton)
        commentView.onTapDissmisKeyboard(VC: self)

        commentTextAndSend.commentAddedDelegate = commentView
        commentTextAndSend.configureAddComment(withProduct: product)
        commentTextAndSend.anchorWithPadding(top: footerArea.bottomAnchor, leading: scrollContentView.leadingAnchor, bottom: nil, trailing: scrollContentView.trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize(width: 0, height: 60))
        
        
        commentView.anchorWithPadding(top: commentTextAndSend.bottomAnchor, leading: scrollContentView.leadingAnchor, bottom: scrollContentView.bottomAnchor, trailing: scrollContentView.trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize(width: 0, height: 0))
        
        
        
        
    }
    
    private func loadData(updatedProduct:CommProduct){
        setHeader(userID: updatedProduct.ownerID, date: updatedProduct.date)
        InfoView.setInfo(image: Images.commCountImage, inGame: updatedProduct.inShares, total: updatedProduct.totalShares, price: updatedProduct.sharePrice)
  
        NetworkManager.Shared.getProductShares(productID: updatedProduct.id) { [weak self] result in
            guard let self = self else{return}
            switch (result){
            case .failure(let error):
                print(error)
            case .success(let users):
                self.sharesView.setUsers(users: users)
                self.checkForCompltedShare(product:updatedProduct)
                self.checkForUseralreadyJoined(userIDs:users)
            }
        }
        
        
    }
    
    private func setHeader (userID:String,date:Double){
        NetworkManager.Shared.getUserInfo(userID: userID){ [weak self] user in
            guard let self = self else {return}
            self.userHeader.set(avatarUrl: user.avatarUrl, username:user.userName, rating: user.userRating, date: date)
            
        }

  }
    
   
    
    
    
}


extension DetailedProductVC{
    
    
    
    private func configureJoinButton(){
        self.sharesView.joinButton.addTarget(self, action: #selector(joinShare), for: .touchUpInside)
        
    }
    
    @objc func joinShare(){
       // reload shares collection view or Not
        NetworkManager.Shared.addShare(productID: product.id) { [weak self]shareAdded in
            guard let self = self else{return}

            switch(shareAdded){
            case false:
                print("shareNotadded")
            case true:
                // need to product data from DB and update ui
                DispatchQueue.main.async {
                    self.reloadData()
                }
                
            }
        }
    
    }
    
    
    
  
    private func reloadData(){
        let loadignView = showLoadingView()
        NetworkManager.Shared.getSingleProduct(productID: product.id) { [weak self]product in
            loadignView.removeFromSuperview()
            guard let self = self else {return}
            guard let product = product else{
                self.view.showAlertView(avatarImage: AlertImages.topAlertImage!, Message: "Sorry we cannot update product page please try agian .", buttonLabel: "Done", buttonImage: .checkmark)
                return
            }
            
            self.loadData(updatedProduct: product)
        }
    }
    
    
    private func checkForCompltedShare(product:CommProduct){
        if product.inShares == product.totalShares{
            setButtoneDisabled(buttonState: "Completed")
        }
    }
    
    private func checkForUseralreadyJoined(userIDs:[String]){
        guard let userID = NetworkManager.Shared.getCurrentUser()else{
            return
        }
        
        if userIDs.contains(userID){
            setButtoneDisabled(buttonState: "Joined")
        }
        
    }
    
    private func  setButtoneDisabled(buttonState:String){
        sharesView.changeJoinButtonState(enabled: false, label: buttonState)
    }
    
    
    ///
    
    private func configureCommentButton(){
        footerArea.commentButton.addTarget(self, action: #selector(commecntTapped), for: .touchUpInside)
        
    }
    
    @objc func commecntTapped(){
        //scroll to bottom of screen .
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    
    private func configureFavButton(){
        footerArea.favButton.configureProduct(withProduct: product.id)
        
    }
    
    // keyboard handling
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

