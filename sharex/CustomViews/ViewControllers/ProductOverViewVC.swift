//
//  ProductOverViewVC.swift
//  sharex
//
//  Created by Amr Moussa on 14/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class ProductOverViewVC: UIViewController {
    
    let header = CellHeader()
    var imageSlider = ImageSlider()
    let productInfo = CommunityCellInfoView()
    let CellFooter = CommCellFooter()
    let productDesc = ProductItemLable(textAlignment: .left,NoOfLines: 0)
    let nameLabel  = ProductItemLable(textAlignment: .left,NoOfLines: 1)
    
    var product : CommProduct!
    var delegate:viewDetailedViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTappedGetNow()
        configureCommentTapped()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NetworkManager.Shared.currentRootVC = self
        setHeader(userID: product.ownerID, date: product.date)
        setImagesSlider(productID: product.id)
        setNameAndDesc(name: product.name, desc: product.descritption)
        setInfo(inGameCount: product.inShares, totalCount: product.totalShares, shareprice: product.sharePrice, originalPrice: product.originalPrice)
    }
   
    
    private func configure(){
        title = "OverView"
        
        view.addSubViews(header,imageSlider,productInfo,
                         CellFooter,productDesc,nameLabel)
        
        let padding:CGFloat = 5
        let imageViewerHeight:CGFloat = DeviceTypes.isSmallSEAndMini ? 200:300
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            header.heightAnchor.constraint(equalToConstant: 60),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageSlider.topAnchor.constraint(equalTo: header.bottomAnchor, constant: padding),
            imageSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageSlider.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageSlider.heightAnchor.constraint(equalToConstant: imageViewerHeight),
            
            productInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            productInfo.topAnchor.constraint(equalTo: imageSlider.bottomAnchor, constant: padding),
            productInfo.heightAnchor.constraint(equalToConstant: 60),
            productInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            CellFooter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            CellFooter.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            CellFooter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            CellFooter.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding*2),
            nameLabel.topAnchor.constraint(equalTo: productInfo.bottomAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            productDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding*2),
            productDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            productDesc.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
        ])
        
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureTappedGetNow(){
        CellFooter.getButton.addTarget(self, action: #selector(joinCommentTapped), for: .touchUpInside)
        
    }
    
    
    
    private func configureCommentTapped(){
        CellFooter.commentButton.addTarget(self, action: #selector(joinCommentTapped), for: .touchUpInside)
    }
    
    @objc func joinCommentTapped(){
//        dismiss(animated: true)
        dismiss(animated: true) {
            self.delegate?.showDetailedWith(product: self.product)
        }
        
    }
    
    func setProduct(){
        
    }
    
    func setHeader (userID:String,date:Double){
        NetworkManager.Shared.getUserInfo(userID: userID){ [weak self] user in
            guard let self = self else {return}
            self.header.set(avatarUrl: user.avatarUrl, username:user.userName, rating: user.userRating, date: date)
            
        }
        
        
        
        
    }
    
    func setImagesSlider(productID:String){
        NetworkManager.Shared.getImagesUrlsForProduct(productID: productID) { [weak self]imgArr in
            guard let self = self else {return }
            self.imageSlider.setImages(imgArr: imgArr,Animated: true,interval: 2.0)
        }
        CellFooter.favButton.configureProduct(withProduct: productID)
    }
    
    func setNameAndDesc(name:String,desc:String){
        nameLabel.text = name.capitalized
        nameLabel.configureAsHeadline()
        productDesc.text = desc
        productDesc.textColor = .secondaryLabel
        
    }
    
    func setInfo(inGameCount:Int,totalCount:Int,shareprice:Double,originalPrice:Double){
        productInfo.setInfo(image: Images.commCountImage, inGame: inGameCount, total: totalCount, price: shareprice)
    }
   
    func configureAsJoined(){
        CellFooter.getButton.configureAsJoined(enabled: true)
    }
    
    
    
}

protocol viewDetailedViewProtocol {
    func showDetailedWith(product:CommProduct)
}





