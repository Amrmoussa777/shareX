//
//  ChosseImagesView.swift
//  sharex
//
//  Created by Amr Moussa on 03/08/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit



class ChooseImagesView: UIView {
    
    
    let chooseButton = ShareButton(text: "Choose Images", bGColor: .orange, iconImage: Images.plusImage)
   
    var imagesCollectionView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    var images:[UIImage] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        
        imagesCollectionView = UICollectionView(frame:self.bounds , collectionViewLayout: layout)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.collectionViewLayout = layout
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.register(ImageSliderCell.self, forCellWithReuseIdentifier: ImageSliderCell.cellID)
        translatesAutoresizingMaskIntoConstraints = false
        imagesCollectionView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        
        addSubViews(imagesCollectionView,chooseButton)
        let padding:CGFloat = 10
        
        chooseButton.anchorWithPadding(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding), size: CGSize(width: 0, height: 60))
        imagesCollectionView.anchorWithPadding(top: chooseButton.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), size: CGSize(width: 0, height: 0))
        
    }
    
    func setImages(imgs:[UIImage]){
        DispatchQueue.main.async {
            self.images = imgs
            self.imagesCollectionView.reloadData()
        }
    }
    
    func getImages()->[UIImage]{
        return self.images
    }
    
}

extension ChooseImagesView:UICollectionViewDelegate,
                      UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSliderCell.cellID, for: indexPath) as! ImageSliderCell
        cell.setImage(img: images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}
