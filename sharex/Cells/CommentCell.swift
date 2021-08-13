//
//  CommentCell.swift
//  sharex
//
//  Created by Amr Moussa on 21/07/2021.
//  Copyright © 2021 Amr Moussa. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    static let cellID  = "CommentCell"
    
    let cellHeader = CellHeader(cellType: .comment)
    let commentBody = ProductItemLable(textAlignment: .left, NoOfLines: 3, size: CGFloat(18))
    let cellFootter = CommentCellFooter()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        backgroundColor = .systemBackground
        commentBody.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        commentBody.textColor = .secondaryLabel
        
        let padding:CGFloat = 5
        addSubViews(cellHeader,cellFootter,commentBody)
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cellHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cellHeader.heightAnchor.constraint(equalToConstant: 60),
            
            cellFootter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellFootter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cellFootter.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            cellFootter.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            commentBody.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            commentBody.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            commentBody.topAnchor.constraint(equalTo: cellHeader.bottomAnchor, constant: -30),
            
            
        ])
        
    }
    
    func setComment(comment:Comment){
        getUserInfo(comment:comment)
        commentBody.text = comment.commentBody
        commentBody.sizeToFit()
        cellFootter.setData(favCount: comment.favCount, userLiked: comment.favOrNot)
        cellFootter.favButton.favCommentDelegate = self
    }
    
    func setFav(product:CommProduct,comment:Comment){
        cellFootter.favButton.configureComment(withComment: comment.commentID, productID: product.id)
        reloadFavICons(product: product, comment: comment)
    }
    private func configureComment(){
        
    }
    private func reloadFavICons(product:CommProduct,comment:Comment){
        NetworkManager.Shared.getCommentLike(product: product, comment: comment) { [weak self]isFavOrNot in
            guard let self = self else{return}
            switch(isFavOrNot){
            case false:
                break
            case true:
                self.cellFootter.setData(favCount: comment.favCount, userLiked: true)
            }
        }
        
    }
    private func getUserInfo(comment:Comment){
        NetworkManager.Shared.getUserInfo(userID: comment.commetOwnerID) {[weak self] user in
            guard let self = self else{return}
            self.cellHeader.setComment(user: user, date: comment.commentDate)
        }
    }
    
    
}

extension CommentCell:commentlikedDeleagte{
 
    func reloadCommnetFooter(commentID: String, productID: String, liked: Bool) {
        NetworkManager.Shared.getSingleComment(withProduct: productID, commentID: commentID) { optComment in
            
            guard let comment = optComment else {
                return
            }
            self.cellFootter.setData(favCount: comment.favCount, userLiked: liked)
            
        }
    }
    
    
}
