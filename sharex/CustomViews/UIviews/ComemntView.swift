//
//  ComemntView.swift
//  sharex
//
//  Created by Amr Moussa on 21/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit


class CommentVeiw: UIView {
    
    var commentCollectionView:UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    var product:CommProduct?
    var comments:[Comment] = []
    var commentButton:ShareButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        

        commentCollectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        commentCollectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.cellID)
     
        
        addSubview(commentCollectionView)
        commentCollectionView.pinToSuperViewSafeArea(in: self)
        translatesAutoresizingMaskIntoConstraints = false
        commentCollectionView.backgroundColor = .systemBackground
        
    }
    func configureCommentButton(commentButton:ShareButton){
        self.commentButton = commentButton
        self.commentButton?.setCommentTitle(commentCount: comments.count)
    }
    
    
    
    func loadComments(){
        //call DB to get Data
        guard let product = product else {
            return
            
        }
    
        let loadingView = showLoadingView()
        NetworkManager.Shared.getComments(withProduct: product) {[weak self] comments in
            guard let self = self else {return}
            loadingView.removeFromSuperview()
            self.comments = comments
            self.commentButton?.setCommentTitle(commentCount: comments.count)
            self.commentCollectionView.reloadData()
        }
        
    }
    
    
    
    
}


extension CommentVeiw:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.cellID, for: indexPath) as! CommentCell
        cell.setComment(comment: comments[indexPath.row])
        cell.setFav(product:product!, comment: comments[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding:CGFloat = 10
        let sizeWidth = collectionView.frame.size.width - padding
        
        return CGSize(width: sizeWidth, height: 150)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}

extension CommentVeiw:commentAdded{
    
    func UpdateComments() {
        loadComments()
        
    }
   
}
